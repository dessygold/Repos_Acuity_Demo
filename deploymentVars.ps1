
# Environemnt agnostic variables
$tenant_Id = 'f5cf1236-30f1-46d6-9501-ca5a5bb5a5b8' # CPMO Temp Tenant
$environment = "AzureCloud" # Get-AzureRmEnvironment | Select-Object Name

# Mgmt variables used to access Service Principle and Keyvault Secret
$mgmt_subscription_Id = '5523bf94-4e92-4d91-bfb6-7b29c4a2b04b' # CPMO Temp Tenant
$mgmt_projectPrefix = 'se-azure'
$mgmt_sa_prefix = 'seazure'
$mgmt_envIdentifier = "mgmt"

# Subscription deployment specific variables
$subscription_Id = 'a649458f-3987-4c7d-a09c-5717143207ce' # CPMO Temp Tenant
$projectPrefix = 'se-azure'
$sa_prefix = 'seazure'
$envIdentifier = "prd"
$regionSuffix = "eus1"
$azRegion = 'eastus'

#Select-AzSubscription -SubscriptionId <your-subscriptionId>  
