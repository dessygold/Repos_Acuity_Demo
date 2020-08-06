# Imports 'deploymentVars.ps1' from repo root, which contains the global variables used in this script
#. ..\..\deploymentVars.ps1
. ..\..\testDeploymentVars.ps1

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
Set-AzContext -Tenant $tenant_Id -SubscriptionId $subscription_Id
Write-Host "Checking context...";
$context = Get-AzContext
if($context -ne $null){ 
  if(!(($context.Tenant.Id -match $context.Tenant.Id) -and ($context.Subscription.Id -match $context.Subscription.Id))){
  do{
    Clear-AzContext -Force
    Connect-AzAccount -Environment $environment -TenantId $tenant_Id -Subscription $subscription_Id
    $context = Get-AzContext
    }
  until($context -ne $null)
  }
}
else{
  Connect-AzAccount -Environment $environment -TenantId $tenant_Id -Subscription $subscription_Id
}

# Create core Resource Group
$rg = Get-AzResourceGroup -Name $core_rg_Name -Location $azRegion
if ($rg -ne $null) {
  Write-Output "Resource Group '$($rg.ResourceGroupName)' already exists"
}
else{
  New-AzResourceGroup -Name $core_rg_Name -Location $azRegion
}