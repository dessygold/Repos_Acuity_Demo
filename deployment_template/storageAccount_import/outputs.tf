
# Must create this modules output, using the output name created in the parent module "sa_1_name" 
output "storage_account_name" {
  value = module.storageAccount.sa_1_name
}

output "container-1_name" {
  value = module.storageAccount.sa_1_con_1_name
}

output "container-2_name" {
  value = module.storageAccount.sa_1_con_2_name
}

output "container-1_id" {
  value = module.storageAccount.sa_1_con_1_id
}

output "container-2_id" {
  value = module.storageAccount.sa_1_con_2_id
}
