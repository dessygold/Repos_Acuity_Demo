
# Environemnt agnostic variables
$tenant_Id = 'af7bf8fc-3102-4ecb-a821-54d806584e58' # Gold  Tenant
$environment = "AzureCloud" # Get-AzureRmEnvironment | Select-Object Name

# Mgmt variables used to access Service Principle and Keyvault Secret
$mgmt_subscription_Id = '625f0f3f-397f-43fd-ab0c-53ae2dc9e9d0' # CPMO Temp Tenant
$mgmt_projectPrefix = 'segold'
$mgmt_sa_prefix = 'storagegold'
$mgmt_envIdentifier = "goldenv"

# Subscription deployment specific variables
$subscription_Id = '625f0f3f-397f-43fd-ab0c-53ae2dc9e9d0' # CPMO Temp Tenant
$projectPrefix = 'segold'
$sa_prefix = 'storagegold'
$envIdentifier = "goldenv"
$regionSuffix = "eus1"
$azRegion = 'eastus'

#Select-AzSubscription -SubscriptionId <your-subscriptionId>  