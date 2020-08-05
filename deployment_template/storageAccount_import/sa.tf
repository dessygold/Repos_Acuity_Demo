#Create Storage Account from the module
module "storage_account_tfmodule_prototype" {
    
 #source                   = "https://gitlabcssdev.fan.gov/cpmo_azure/management_code.git//modules/Storage_Account?ref=${var.release_version}"
  source                   = "./../modules/storageAccount"
  #version                 = "1.0.0"
  resource_group_name      = data.azurerm_resource_group.core-rg.name
  location                 = data.azurerm_resource_group.core-rg.location
  sa_prefix                = var.sa_prefix 
  env_ident                = var.env_ident
  region_suffix            = var.region_suffix 
  project_ident            = var.project_ident

}