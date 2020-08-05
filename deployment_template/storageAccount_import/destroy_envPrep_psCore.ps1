# Imports 'deploymentVars.ps1' from repo root, which contains the global variables used in this script
#. ..\..\deploymentVars.ps1
. ..\..\testDeploymentVars.ps1

#Error Messages:
Set-Item Env:\SuppressAzurePowerShellBreakingChangeWarnings "true"
$ErrorActionPreference = "silentlyContinue"

# Variables
$core_rg_Name = "$projectPrefix-$envIdentifier-core-rg-$regionSuffix"
$tf_state_sa_sku = 'Standard_RAGRS'
$tf_state_sa_name = $sa_prefix + $envIdentifier + "tfstate" + $regionSuffix
$tf_state_sa_containers = "terraform-state-$projectPrefix-$envIdentifier","$projectPrefix-$envIdentifier-deployment-scripts"

# Login to Azure Resource Management portal
#Connect-AzAccount -Environment $environment -Tenant $tenant_Id -Subscription $subscription_Id -Force
az cloud set --name $environment
az account set --subscription $subscription_Id
az login
Write-Host "Checking context...";
$context = Get-AzContext
if($context -ne $null){
  if(!(($context.TenantId -match $context.Tenant.Id) -and ($context.Subscription.Id -match $subscription_Id))){
  do{
    Disable-AzContextAutosave -Scope Process
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

# Delete Terraform state storage account
$tfsa = Remove-AzStorageAccount -Name $tf_state_sa_name -ResourceGroupName $core_rg_Name -Force
Write-Output "Storage Account '$($tf_state_sa_name)' has been deleted" -Verbose

# Deletes the Resource Group, and all remaining resources within it
$rg = Remove-AzResourceGroup -Name $core_rg_Name -Force
Write-Output "Resource Group '$($rg.ResourceGroupName)' has been deleted" -Verbose
