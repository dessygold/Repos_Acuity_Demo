# Imports 'deploymentVars.ps1' from repo root, which contains the global variables used in this script
#. ..\..\deploymentVars.ps1
. ..\..\testDeploymentVars.ps1

## Performsa Terraform Import, into remote state for the following resources:
  # Azure storage acccount for tfstate files
  # Azure storage account container for tfstate files
  
# Mgmt Variables
  $kvName = "$mgmt_projectPrefix-$mgmt_envIdentifier-kv-$regionSuffix"
  $spDisplayName = "$mgmt_projectPrefix-$mgmt_envIdentifier-terraform-sp"
  $kvName = "$mgmt_projectPrefix-$mgmt_envIdentifier-kv-$regionSuffix"
  $kvSecret = "$mgmt_projectPrefix-$mgmt_envIdentifier-terraform-sp-pw"

# Deployment Variables
  $tf_state_rg = "$projectPrefix-$envIdentifier-core-rg-$regionSuffix"
  $tf_state_sa_name = $sa_prefix + $envIdentifier + "tfstate" + $regionSuffix
  $tf_state_sa_container1 = "terraform-state-$projectPrefix-$envIdentifier"
  $tf_state_sa_container2 = "$projectPrefix-$envIdentifier-deployment-scripts"

## Login for Mgmt Subscription KeyVault
  Set-AzContext -Tenant $tenant_Id -SubscriptionId $mgmt_subscription_Id
  Write-Host "Checking context...";
  $context = Get-AzContext
  if($context -ne $null){ 
    if(!(($context.Tenant.Id -match $context.Tenant.Id) -and ($context.Subscription.Id -match $context.Subscription.Id))){
    do{
      Clear-AzContext -Force
      Connect-AzAccount -Environment $environment -TenantId $tenant_Id -Subscription $mgmt_subscription_Id
      $context = Get-AzContext
      }
    until($context -ne $null)
    }
  }
  else{
    Connect-AzAccount -Environment $environment -TenantId $tenant_Id -Subscription $mgmt_subscription_Id
  }

# Retrieve Application ID os Service Principal
  $tf_sp_appid = (Get-AzADServicePrincipal -DisplayName $spDisplayName).ApplicationId.Guid

# Retrieve Terraform Service Principal password from Key Vault
  $terraform_sp_secret = (Get-AzKeyVaultSecret -VaultName $kvName -Name $kvSecret).SecretValueText

## Login for Deployment Subscription 
  Set-AzContext -Tenant $tenant_Id -SubscriptionId $subscription_Id

# Get storage account key for the storage account where Terraform state files will be stored
  $tf_state_key = (Get-AzStorageAccountKey -ResourceGroupName $tf_state_rg -AccountName $tf_state_sa_name | Where-Object{$_.KeyName -eq 'key1'}).Value

## Imports Storage Account
terraform import `
  -var "tenant_id=$tenant_Id" `
  -var "subscription_Id=$subscription_Id" `
  -var "tf_sp_appid=$tf_sp_appid" `
  -var "tf_sp_secret=$terraform_sp_secret" `
  -var "tfstate_access_key=$tf_state_key" `
  -var "project_ident=$projectPrefix" `
  -var "region_suffix=$regionSuffix" `
  -var "env_ident=$envIdentifier" `
  -var "sa_prefix=$sa_prefix" `
  module.storageAccount.azurerm_storage_account.storage-account-1 /subscriptions/$subscription_Id/resourceGroups/$tf_state_rg/providers/Microsoft.Storage/storageAccounts/$tf_state_sa_name

## Imports Storage Account Container housing TF State Files
terraform import `
  -var "tenant_id=$tenant_Id" `
  -var "subscription_Id=$subscription_Id" `
  -var "tf_sp_appid=$tf_sp_appid" `
  -var "tf_sp_secret=$terraform_sp_secret" `
  -var "tfstate_access_key=$tf_state_key" `
  -var "project_ident=$projectPrefix" `
  -var "region_suffix=$regionSuffix" `
  -var "env_ident=$envIdentifier" `
  -var "sa_prefix=$sa_prefix" `
  module.storageAccount.azurerm_storage_container.container-1 "https://$tf_state_sa_name.blob.core.windows.net/$tf_state_sa_container1"
  #https://seazuremgmttfstateeus1.blob.core.windows.net/terraform-state-se-azure-mgmt

## Imports Storage Account Container housing VM deployment-scripts
terraform import `
  -var "tenant_id=$tenant_Id" `
  -var "subscription_Id=$subscription_Id" `
  -var "tf_sp_appid=$tf_sp_appid" `
  -var "tf_sp_secret=$terraform_sp_secret" `
  -var "tfstate_access_key=$tf_state_key" `
  -var "project_ident=$projectPrefix" `
  -var "region_suffix=$regionSuffix" `
  -var "env_ident=$envIdentifier" `
  -var "sa_prefix=$sa_prefix" `
  module.storageAccount.azurerm_storage_container.container-2 "https://$tf_state_sa_name.blob.core.windows.net/$tf_state_sa_container2"
  #https://seazuremgmttfstateeus1.blob.core.windows.net/terraform-state-se-azure-mgmt

# Once imported, use Terraform Show information to ensure resource block information matches for each resource in the .tf files
terraform show
