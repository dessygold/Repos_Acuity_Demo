
## To skip CI build on code commit
# Add the following to the commit message
# [ci skip]

## Configuring 'management_code' repo, to push to CPMO Gitlab Dev, and Gitlab PRD severs
git remote add origin https://gitlabcssdev.fan.gov/cpmo_azure/management_code.git
git remote set-url --add --push origin https://gitlabcssdev.fan.gov/cpmo_azure/management_code.git
git remote set-url --add --push origin https://gitlabcss.fan.gov/cpmo_azure/management_code.git

## Check Configured Remotes
git remote -v

## Push to both Gitlab Dev and Gitlab Prd
git push origin

    # Remove Push Remote
    # git remote set-url --push origin no_push

    # Remove all Origins completely, including main repo 
    # git remote rm origin

## Git Commands to: 
# Add (stage) all new files in local git
# Commit changes with commit message that references Jira Issue, to link commit to Jira issue Comments
git add --all
git commit -m "Work completed for AZR-99" 
git push origin 

## Remote Git branch Locally
git branch -D feature_azr-99

## Remote Git branch from Remote
git push origin --delete feature_azr-99

## Merge new changes in develop, to feature_branch
# Ensures feature_branch is not behind develop, prior to merge requests
git checkout develop
git pull origin develop
git checkout feature_branch
git merge develop