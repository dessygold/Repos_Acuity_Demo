## Build number must be incremented for each feature / bug merge on the Develop branch / Release_Branches
  # $buildNumber will be pushed as a -tag, on merge, based on $build
  
## Automated Script
$file = "./" + "releaseVersion.txt"
$versionparts = (get-content -Path $file).split('.')
([int]$versionparts[-1])++
$versionparts -join('.') | set-content $file
$buildVersion = get-content -Path $file

#git -tag $buildVersion
  # 1.0.0.1

## Abort merge request, during merge process
# git merge --abort