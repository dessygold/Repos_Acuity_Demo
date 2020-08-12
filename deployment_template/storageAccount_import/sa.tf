
module "storageAccount" {
  source                   = "git::https://github.com/dessygold/Repos_Acuity_Demo/tree/sa-prototype-azr-201/modules/storageAccount?ref=sa-prototype-azr-20"# ref=<release_version>
  # source                   = "git::https://gitlabcssdev.fan.gov/cpmo_azure/deployment_code.git//modules/storageAccount?ref=sa-prototype-azr-201" # ref=<release_version>
  resource_group_name      = data.azurerm_resource_group.core-rg.name
  location                 = data.azurerm_resource_group.core-rg.location
  sa_prefix                = var.sa_prefix 
  env_ident                = var.env_ident
  region_suffix            = var.region_suffix 
  project_ident            = var.project_ident
}