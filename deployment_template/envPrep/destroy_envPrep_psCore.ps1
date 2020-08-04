# Imports 'deploymentVars.ps1' from repo root, which contains the global variables used in this script
. ..\..\deploymentVars.ps1

#Error Messages:
Set-Item Env:\SuppressAzurePowerShellBreakingChangeWarnings "true"
$ErrorActionPreference = "silentlyContinue"

# Variables
$subscriptionAdmins = "Gianni@doscpmosandboxoutlook.onmicrosoft.com"
$core_rg_Name = "$projectPrefix-$envIdentifier-core-rg-$regionSuffix"
$kvName = "$projectPrefix-$envIdentifier-kv-$regionSuffix"
$keyvault_admGroup = "$projectPrefix-$envIdentifier-kv-$regionSuffix-kvAdmins"
$keyvault_rdrGroup = "$projectPrefix-$envIdentifier-kv-$regionSuffix-kvReaders"
$tf_state_sa_sku = 'Standard_RAGRS'
$tf_state_sa_name = $sa_prefix + $envIdentifier + "tfstate" + $regionSuffix
$tf_state_sa_containers = "terraform-state-$projectPrefix-$envIdentifier","$projectPrefix-$envIdentifier-deployment-scripts"
$spDisplayName = "$projectPrefix-$envIdentifier-terraform-sp"
$spAppKeyName = "sp_Key_1"
$spAppkeySecretName = "$projectPrefix-$envIdentifier-terraform-sp-pw"
$homePage = 'http://localhost'
$identifierUris = "http://$spDisplayName"
$spScopeSub = "/subscriptions/$subscription_Id" # Use for -Scope when making Service Principal for entire subscription
#$spScopeRG = "/subscriptions/$subscriptionId/ResourceGroups/$rgName" # Use for -Scope when making Service Principal for a specific Resource Group

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

# Delete Terraform Azure AD app registration
$sp = Get-AzADServicePrincipal -DisplayName $spDisplayName
Remove-AzADServicePrincipal -ObjectId $sp.Id -Force
Write-Output "Service Principal '$($sp.DisplayName)' has been deleted" -Verbose

# Delete Terraform Service Principal
$aadApp = Get-AzADApplication -DisplayName $spDisplayName
Remove-AzADApplication -ObjectId $aadApp.ObjectId -Force  
Write-Output "App Registration '$($aadApp.DisplayName)' has been deleted" -Verbose

# Delete Terraform state storage account
$tfsa = Remove-AzStorageAccount -Name $tf_state_sa_name -ResourceGroupName $core_rg_Name -Force
Write-Output "Storage Account '$($tf_state_sa_name)' has been deleted" -Verbose

# Deletes Key Vault
$kv = Remove-AzKeyVault -VaultName $kvName -Force
Write-Output "Key Vault '$($kvName)' has been deleted" -Verbose

# Delete Key Vault Admins group 
$kvAdmGroup = Remove-AzADGroup -DisplayName $keyvault_admGroup -Force
Write-Output "AAD Group '$($keyvault_admGroup)' has been deleted" -Verbose

# Delete Key Vault Readers group
$kvRdrGroup = Remove-AzADGroup -DisplayName $keyvault_rdrGroup -Force
Write-Output "AAD Group '$($keyvault_rdrGroup)' has been deleted" -Verbose

# Deletes the Resource Group, and all remaining resources within it
  # $rg = Remove-AzResourceGroup -Name $core_rg_Name -Force
  # Write-Output "Resource Group '$($rg.ResourceGroupName)' has been deleted" -Verbose
