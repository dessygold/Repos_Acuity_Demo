# Imports 'deploymentVars.ps1' from repo root, which contains the global variables used in this script
#. ..\..\deploymentVars.ps1
. ..\..\testDeploymentVars.ps1

#Error Messages:
Set-Item Env:\SuppressAzurePowerShellBreakingChangeWarnings "true"
$ErrorActionPreference = "silentlyContinue"

# Variables
$core_rg_Name = "$projectPrefix-$envIdentifier-core-rg-$regionSuffix"
$tf_state_sa_name = $sa_prefix + $envIdentifier + "tfstate" + $regionSuffix

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

# Delete Terraform state storage account
$tfsa = Remove-AzStorageAccount -Name $tf_state_sa_name -ResourceGroupName $core_rg_Name -Force
Write-Output "Storage Account '$($tf_state_sa_name)' has been deleted" -Verbose

# Deletes the Resource Group, and all remaining resources within it
$rg = Remove-AzResourceGroup -Name $core_rg_Name -Force
Write-Output "Resource Group '$($core_rg_Name)' has been deleted" -Verbose
