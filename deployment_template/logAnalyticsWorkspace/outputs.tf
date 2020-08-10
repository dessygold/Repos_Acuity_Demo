
# Must create this modules output, using the output name created in the parent module "sa_1_name" 

output "workspace_key" {
  value = module.logAnalyticsWorspace.workspace_key
}

output "workspace_id" {
  value = module.logAnalyticsWorspace.workspace_id
}

output "workspace_name" {
  value = module.logAnalyticsWorspace.workspace_name
}