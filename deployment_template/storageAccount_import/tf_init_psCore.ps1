# Imports 'deploymentVars.ps1' from repo root, which contains the global variables used in this script
#. ..\..\deploymentVars.ps1
. ..\..\testDeploymentVars.ps1

# Variables
$tf_state_rg = "$projectPrefix-$envIdentifier-core-rg-$regionSuffix"
$tf_state_sa_name = $sa_prefix + $envIdentifier + 'tfstate' + $regionSuffix
$tf_state_sa_container = "terraform-state-$projectPrefix-$envIdentifier"

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
    Connect-AzAccount -Environment $environment -TenantId $tenant_Id -Subscription $subscription_Id
  }

# Get storage account key for the storage account where Terraform state files will be stored
  $tf_state_key = (Get-AzStorageAccountKey -ResourceGroupName $tf_state_rg -AccountName $tf_state_sa_name | Where-Object{$_.KeyName -eq 'key1'}).Value

## Terraform init
  Terraform init -upgrade `
  -backend-config="access_key=$tf_state_key" `
  -backend-config="environment=public" `
  -backend-config="resource_group_name=$tf_state_rg" `
  -backend-config="storage_account_name=$tf_state_sa_name" `
  -backend-config="container_name=$tf_state_sa_container" `
  -backend-config="key=$projectPrefix-$envIdentifier-sa-$regionSuffix.terraform.tfstate"
