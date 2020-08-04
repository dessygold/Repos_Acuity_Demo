
########################################################################################################################
# Deployment Variables, with INPUT REQUIRED
########################################################################################################################
$envType             = "Dev" #must be CAPs for profile name
$env                 = "5662-6406-9176" # (gianni_vazzana_tfTest) AWS Account# to stamp
$region              = "us-east-1" # Region for resource provisioning in this deployment (us-east-1)
$deploymentVersion   = '1.1.0'
$branch              = "master" # Release_1.1.0
$buildConfigFile     = 'skinnyBuildConfig.csv' # baselineBuildConfig.csv
$awsProfileName      = "cssAssumeRole" # .aws/credential profile with programmatic credentials to access AWS Secrets Manager (css-dev)
########################################################################################################################

########################################################################################################################
## Terraform Module Parameter Inputs ##
########################################################################################################################

## 'vpc' Module:
$vpcCidrBlocks        = ""
$privateSubs          = "10.0.1.0/24`",`"10.0.2.0/24"
$privateSubnets       = $privateSubs -join "," # Private Subnet count is based on how many subnets are in this list variable
$publicSubs           = ""
$publicSubnets        = $publicSubs -join "," # Private Subnet count is based on how many subnets are in this list variable

########################################################################################################################

########################################################################################################################
# Variables, with NO INPUT NEEDED
########################################################################################################################
$prj                                = "account" # Prefix used for deployment name (account_xxxx-xxxx-xxxx)
$gitCloneFolderName                 = "Git_Lab\AWS_Terraform_OpenSource"
$vcsTriggerBranch                   = $branch
$access_key_id_secret_Name          = "css-core-terraform-access-key-id" # Name of the AWS Secrets Manager Secret for AWS Root Account IAM access key id
$secret_access_key_secret_Name      = "css-core-terraform-secret-access-key" # Name of the AWS Secrets Manager Secret for AWS Root Account IAM secret access key

# Build Config File Location ("css_deployment_code" repository)
$localDir                           = "c:\$localCodeDir"
$gitURL2                            = "https://gitlab.com/aws_terraform_opensource/css_deployment_code.git"
$gitDir2                            = ($gitURL2 -split '/')[-1] # Takes the last section split by '/' (terraform_cloud.git)
$gitDir2                            = $gitDir2.Replace(".git","") # Replaces '.git' with a blank entry ""
$gitCloneDir2                       = Join-Path $localDir $gitDir2
$gitBuildConfigFilePath             = Join-Path $gitCloneDir2 "\_config_files\build_configs"
$buildConfigLocation                = Join-Path $gitBuildConfigFilePath $buildConfigFile # Build configuration file to use 
