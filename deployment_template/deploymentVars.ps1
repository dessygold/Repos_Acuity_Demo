
# Variables used through out this deployment
$tenant_Id = 'f5cf1236-30f1-46d6-9501-ca5a5bb5a5b8' # CPMO Temp Tenant
$subscription_Id = '5523bf94-4e92-4d91-bfb6-7b29c4a2b04b' # CPMO Temp Tenant
$environment = "AzureCloud" # Get-AzureRmEnvironment | Select-Object Name
$projectPrefix = 'se-azure'
$sa_prefix = 'seazure'
$envIdentifier = "mgmt"  
$regionSuffix = "eus1"
$azRegion = 'eastus' 
$releaseVersion = 'feature_azr-14' # 'BranchName' to deploy from

