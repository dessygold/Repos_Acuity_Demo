# Imports 'deploymentVars.ps1' from repo root, which contains the global variables used in this script
. ..\testdeploymentVars.ps1

# Variables
$spDisplayName = "$projectPrefix-$envIdentifier-terraform-sp"
$kvName = "$projectPrefix-$envIdentifier-kv-$regionSuffix"
$kvSecret = "$projectPrefix-$envIdentifier-terraform-sp-pw"
$tf_state_rg = "$projectPrefix-$envIdentifier-core-rg-$regionSuffix"
$tf_state_sa_name = $sa_prefix + $envIdentifier + "tfstate" + $regionSuffix

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

# Retrieve Application ID os Service Principal
  $tf_sp_appid = (Get-AzADServicePrincipal -DisplayName $spDisplayName).ApplicationId.Guid

# Retrieve Terraform Service Principal password from Key Vault
  $terraform_sp_secret = (Get-AzKeyVaultSecret -VaultName $kvName -Name $kvSecret).SecretValueText

# Get storage account key for the storage account where Terraform state files will be stored
  $tf_state_key = (Get-AzStorageAccountKey -ResourceGroupName $tf_state_rg -AccountName $tf_state_sa_name | Where-Object{$_.KeyName -eq 'key1'}).Value

# Execute Terraform configuration
terraform destroy `
    -var "tenant_id=$tenant_Id" `
    -var "subscription_Id=$subscription_Id" `
    -var "tf_sp_appid=$tf_sp_appid" `
    -var "tf_sp_secret=$terraform_sp_secret" `
    -var "tfstate_access_key=$tf_state_key" `
    -var "project_ident=$projectPrefix" `
    -var "region_suffix=$regionSuffix" `
    -var "env_ident=$envIdentifier" `
    -var "sa_prefix=$sa_prefix"
