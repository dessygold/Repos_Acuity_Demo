
# Imports the 'globalDeploymentVars.ps1' file, for use of this deployment's $prj-$env variables
. ./globalVars.ps1

Write-Host "---------------------------------------------------------"
Write-Host "Global Deployment Variables:" -ForegroundColor Yellow
Write-Host "Project = $($prj)" -ForegroundColor Green
Write-Host "Environment = $($env)" -ForegroundColor Green
Write-Host "Region = $($region)" -ForegroundColor Green
Write-Host "---------------------------------------------------------"

# Ignore warnings from objects that exist, or are not found
$ErrorActionPreference = 'SilentlyContinue'

#######################################################################################################################
# Variables from imported "globalDeploymentVars.ps1" file
$projectPrefix    = $prj
$envIdentifier    = $env
$localCodeDir     = $gitCloneFolderName # Git_Lab\AWS_Terraform_OpenSource
$gitBranch        = $branch
$release          = $deploymentVersion
#######################################################################################################################

#######################################################################################################################
# Variables, with NO INPUT NEEDED
$localDir                  = "c:\dos\$localCodeDir" # c:\dos\Git_Lab\AWS_Terraform_OpenSource
$gitURL                    = "https://gitlab.com/aws_terraform_opensource/deployments.git"
$gitURL2                   = "https://gitlab.com/aws_terraform_opensource/deployment_code.git"
# Extracts the Terraform_Cloud Git Repository's Folder name from the Git Clone URL, and removes the '.git'
$gitDir                    = ($gitURL -split '/')[-1] # Takes the last section split by '/' (terraform_cloud.git)
$gitDir                    = $gitDir.Replace(".git","") # Removes ".git", leaving only the repo folder name
$gitCloneDir               = Join-Path $localDir $gitDir
# Extracts the DeploymentScript Git Repository's Folder name from the Git Clone URL, and removes the '.git'
$gitDir2                   = ($gitURL2 -split '/')[-1] # Takes the last section split by '/' (terraform_cloud.git)
$gitDir2                   = $gitDir2.Replace(".git","") # Replaces '.git' with a blank entry ""
$gitCloneDir2              = Join-Path $localDir $gitDir2
$envPrepPath               = Join-Path $gitCloneDir "\_envPrep"
$templatePath              = Join-Path $gitCloneDir2 "\deployment_template"
$newDeploymentDir          = Join-Path $gitCloneDir "\$projectPrefix-$envIdentifier"
$localDeploymentScriptPath = Join-Path $newDeploymentDir "\deployment_script"
$globalVarsFilePath        = "$localDeploymentScriptPath\globalDeploymentVars.ps1"
$gitDeploymentScriptPath   = Join-Path $gitCloneDir2 "\deployment_script"
#######################################################################################################################

## The Following script builds the Git Clone Directory structure for the following Repositories:
# If the folders do not exist, they are created and a Git clone performed
# If the folders already exist, a Git Fetch is performed for the specified branch
  # $gitURL                    = "https://gitlab.com/aws_terraform_opensource/deployments.git"
  # $gitURL2                   = "https://gitlab.com/aws_terraform_opensource/deployment_code.git"

# Change to deployment_script Directory
Set-Location $localDir

# Creates a directory to clone the git repository into, if it does not already exist
if (test-path $localDir) {
    Write-Output "Deployment Directory '$localDir' already exists. You are all set to clone the Git Repo"
}
else {
    $dir = New-Item -ItemType Directory -Path $localDir -Force
    Write-Output "Directory '$($dir.PSPath)' has been created to house this new Terraform deployment"
}

# Enter new deployment directory
Set-Location "$localDir" # cd
write-host "Entering Directory '$localDir'" -ForegroundColor Green


## "deployments" Repository:

# Perform a git clone for the 'deployments" Repo (Customer Deployments Repo), if git clone has not already been performed for this Repository
if (test-path $gitCloneDir) {
    Write-Output "Git Clone appears to already have been performed, based on the existing folder structure"
    Set-Location "$gitCloneDir" # cd
    # Check if "$release" Branch exists. If it does , update the branch
    $existingBranch = git ls-remote --heads origin $release
    if($existingBranch -ne $null){
        Write-Host "Git Branch '$release' already exists. Checking out, and updating branch now" -ForegroundColor Green
        git checkout $release
        git fetch origin $release
    }
    else {
        # If "$release" branch does not exist, create it from master, which has no deployments in it
        git checkout master
        Set-Location "$gitCloneDir" # cd
        Get-ChildItem -exclude _envPrep | Remove-Item -Recurse -Force
        git checkout -b $release
        git push origin $release
        Write-Host "Git Branch '$release' has been created for this deployment, and pushed to remote origin" -ForegroundColor Green
    }
}
else {
    # Performs a git clone for the 'deployments" Repo (Customer Deployments Repo)
    Set-Location "$localDir" # cd
    git clone --single-branch --branch master $gitURL
    Set-Location "$gitCloneDir" # cd
    # Removes any empty directorys from other git branches, to only have deployments that belong to '$gitBranch', show for ease of tracking
    Get-ChildItem -exclude _envPrep | Remove-Item -Recurse -Force
    git checkout -b $release | Out-Null
    git push origin $release | Out-Null
}


## "deployment_code" Repository:

# Performs a git clone for 'deployment_script' Repo, if git clone has not already been performed for this Repository, and performs a 'git fetch' to pull down the newest version of said 'git branch'
if (test-path $gitCloneDir2) {
    Write-Output "Git Clone appears to already have been performed, based on the existing folder structure"
    Set-Location "$gitCloneDir2" # cd
    # Check if "$release" Branch exists. If it does , update the branch
    $existingBranch = git ls-remote --heads origin $gitBranch
    if($existingBranch -ne $null){
        Write-Host "Git Branch '$gitBranch' already exists. Checking out, and updating branch now" -ForegroundColor Green
        git checkout $gitBranch
        git fetch origin $gitBranch
    }
    else {
        # If "$release" branch does not exist, create it from master, which has no deployments in it
        git checkout master
        Set-Location "$gitCloneDir" # cd
        Get-ChildItem -exclude _envPrep | Remove-Item -Recurse -Force
        git checkout -b $gitBranch
        git push origin $gitBranch
        Write-Host "Git Branch '$gitBranch' has been created for this deployment, and pushed to remote origin" -ForegroundColor Green
    }
}
else {
    # Performs a git clone for the 'deployments" Repo (Customer Deployments Repo)
    Set-Location "$localDir" # cd
    git clone --single-branch --branch $gitBranch $gitURL2 
    Set-Location "$gitCloneDir2" # cd
    # Removes any empty directorys from other git branches, to only have deployments that belong to '$gitBranch', show for ease of tracking
    git checkout -b $gitBranch | Out-Null
    git push origin $gitBranch | Out-Null
}

 
# Makes a copy of the '_deployment_template' Folder, and names the new copy '$proj-$env', if it does not already exist
if (test-path $newDeploymentDir) {
    Write-Host "Deployment Directory '$newDeploymentDir' already exists. Pick a new deployment folder name" -ForegroundColor Green
}
else {
Copy-Item $templatePath -Destination $newDeploymentDir –Recurse | Out-Null
Write-Host "New Deployment Directory '$newDeploymentDir' has been created, from '$templatePath' Directory" -ForegroundColor Green
}

# Makes a copy of the 'deployment_script', inside the new deployment folder, to save a copy of the variables used, if it does not already exist
if (test-path "$newDeploymentDir\deployment_script_v2") {
    Write-Host "Deployment Directory '$newDeploymentDir\deployment_script' already exists. Deployment script used for this deployment, has already been successfully captured" -ForegroundColor Green
}
else {
Copy-Item $gitDeploymentScriptPath -Destination $newDeploymentDir –Recurse | Out-Null
Write-Host "Deployment Script used for this deployment has been captured, and copied to the '$newDeploymentDir'" -ForegroundColor Green
}

#######################################################################################################################
# The following Section creates the 'globalDeploymentVars.ps1' file used within all deployment folders
#######################################################################################################################


## New Deployment Folder

    # File Content to use for 'globalDeploymentVars.ps1' content replacement
    $newContent2 = Get-Content -Path $globalVarsFilePath
    
    # Replace content in existing 'globalDeploymentVars.ps1' file, with new content in 'globalDeploymentVars.ps1'
    Set-Content -Path "$newDeploymentDir\globalDeploymentVars.ps1" -Value $newContent2 | Out-Null

    # Deletes 'globalDeploymentVars.ps1' file, from the 'deployment_script' repository, now that the new deployment folder has been created, with variables used captured.
    if (test-path "$gitDeploymentScriptPath") {
        Remove-Item -path "$gitDeploymentScriptPath\globalDeploymentVars.ps1"
        Write-Output "Variables used for this deployment have been removed from the 'deployment_script' repo. To modify, add, or delete variables for this new deployment, please navigate to '$globalVarsFilePath'"
    }
    else {
        write-output "Directory '$gitDeploymentScriptPath' does not exist. Run 'newDeploymentDeployment1_WIP.ps1' script, to create desired Directory"
    }

#######################################################################################################################
# The following Section automates the deployment process, with out the need to enter each deployment folder and input it's variables
#######################################################################################################################

# Enter Deployment folder
    Set-Location "$newDeploymentDir" # cd

    ## Executes the 'globalDeploymentScript_preVCS.ps1' script, which performs all supporting envPrep Powershell scripts, Terraform Init, Terraform Plan, and Terraform Apply scripts
    # globalDeploymentScript_postVCS.ps1 script needs to be run, after manually configuring VCS OAuth Integation with Gitlab and Terraform Cloud
    invoke-expression -Command ./globalDeploymentScript_preVCS.ps1
    Write-Host "Deployment Script 'globalDeploymentScript_preVCS.ps1' has been executed for this Deployment" -ForegroundColor Green
