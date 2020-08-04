
########################################################################################################################
# Deployment Variables, with INPUT REQUIRED
########################################################################################################################
$envType             = "What env does the AWS Account Stamp belong to "# Dev, Prd #must be CAPs for profile name
$env                 = "Enter AWS Account Number: xxxx-xxxx-xxxx"
$region              = "Enter region" # Region for resource provisioning in this deployment (us-east-1, us-east-2, us-west-1, us-west-2)
$deploymentVersion   = 'Enter baseline code deployment version'
$branch              = "Enter branch name, which will be a concatonation of either 'alpha_$deploymentVersion' for a feature branch, or '$deploymentVersion' for a live Release Branch"
$buildConfigFile     = 'skinnyBuildConfig.csv' # skinnyBuildConfig.csv, baselineBuildConfig.csv, baselineBuildConfig_v1.2.csv
$awsProfileName      = "Enter .aws/credential profile name" # .aws/credential profile with programmatic credentials to access AWS Secrets Manager (default)
########################################################################################################################

########################################################################################################################
## Terraform Module Parameter Inputs ##
########################################################################################################################

## 'vpc' Module:
$vpcCidrBlocks        = "Enter VPC CIDR Block in format of: 10.0.1.0/24"
$privateSubs          = "Enter Private Subnet CIDR Block(s) in format of: "10.0.1.0/24`",`"10.0.2.0/24" end of comment" # Private Subnet count is based on how many subnets are in this list variable
$privateSubnets       = $privateSubs -join "," # Private Subnet count is based on how many subnets are in this list variable
$publicSubs           = "Enter Public Subnet CIDR Block(s) in format of: "10.0.1.0/24"   end of comment"
$publicSubnets        = $publicSubs -join "," # Private Subnet count is based on how many subnets are in this list variable

########################################################################################################################

########################################################################################################################
# Variables, with NO INPUT NEEDED
########################################################################################################################
$prj                                = "account" # Prefix used for deployment name (account_xxxx-xxxx-xxxx)
$gitCloneFolderName                 = "Git_Lab\AWS_Terraform_OpenSource"
$vcsTriggerBranch                   = $branch # alpha_v1.1.0, v1.1.0
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
