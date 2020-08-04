# Imports 'deploymentVars.ps1' from repo root, which contains the global variables used in this script
. ..\..\deploymentVars.ps1

## This script tackles the age old rittle, of the chicken before the egg:
# The Script builds the following resources, within the Azure Subscription, which must exist before Terraform State Files can be captured:
    # Resource Group to house Storage Account, and entire deployment
    # Storage Account which serves activites
        # SA Container which holds Terraform state files
        # SA Container which holds resource diagnostic logs

#Error Messages:
Set-Item Env:\SuppressAzurePowerShellBreakingChangeWarnings "true"
$ErrorActionPreference = "silentlyContinue"

# Variables
$core_rg_Name = "$projectPrefix-$envIdentifier-core-rg-$regionSuffix"
$tf_state_sa_sku = 'Standard_RAGRS'
$tf_state_sa_name = $sa_prefix + $envIdentifier + "tfstate" + $regionSuffix
$tf_state_sa_containers = "terraform-state-$projectPrefix-$envIdentifier","$projectPrefix-$envIdentifier-deployment-scripts"

# Login to Azure Resource Management portal
az cloud set --name $environment
az account set --subscription $subscription_Id
az login
Write-Host "Checking context...";
$context = Get-AzContext
if($context -ne $null){
  if(!(($context.Subscription.TenantId -match $tenant_Id) -and ($context.Subscription.Id -match $subscription_Id))){
  do{
    Clear-AzContext -Force
    Connect-AzAccount -Environment $environment -TenantId $tenant_Id
    $context = Get-AzContext
    }
  until($context -ne $null)
  }
}
else{
  Connect-AzAccount -Environment $environment -TenantId $tenant_Id  
}

# Create core Resource Group
$rg = Get-AzResourceGroup -Name $core_rg_Name -Location $azRegion
if ($rg -ne $null) {
  Write-Output "Resource Group '$($rg.ResourceGroupName)' already exists"
}
else{
  New-AzResourceGroup -Name $core_rg_Name -Location $azRegion
}

# Create Terraform state storage account
$tfsa = Get-AzStorageAccount -ResourceGroupName $core_rg_Name -Name $tf_state_sa_name
if ($tfsa -ne $null) {
  Write-Output "Storage Account '$($tfsa.StorageAccountName)' already exists" -Verbose
}
else {
  $tfsa = New-AzStorageAccount -ResourceGroupName $core_rg_Name `
    -Name $tf_state_sa_name `
    -Location $azRegion `
    -SkuName $tf_state_sa_sku
    Write-Output "Storage Account '$($tfsa.StorageAccountName)' has been created"
}

# Create storage account containers for 'Terraform state files', and 'deployment-scripts' used in vm_cse_scripts
Foreach ($container in $tf_state_sa_containers) {
  $saContainer = Get-AzStorageContainer -Name $container -Context $tfsa.context
  if ($saContainer -ne $null) {
    Write-Output "Container(s) '$($saContainer.Name)' already exists"
  }
  else {
    $saContainer = New-AzStorageContainer -Name $container -Context $tfsa.Context -Permission Blob
    Write-Output "Container(s) '$($saContainer.Name)' has been created"
  }
}