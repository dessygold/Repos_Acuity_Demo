
# Initialize the directory
./tf_init_psCore.ps1

# Perform TF Validate, for syntax and linting checks
./tf_validate.ps1

# Import resources into Terraform
./tf_import_psCore.ps1

# Perfom TF Plan, and out to file 'tfplan'
./tf_plan_psCore.ps1

# Perform TF Apply based on 'tfplan' file
./tf_apply_psCore.ps1