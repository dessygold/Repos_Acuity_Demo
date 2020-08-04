
# Build Virtual Network
module "network" {
    source              = "git::https://gitlabcssdev.fan.gov/cpmo_azure/deployment_code.git//modules/network?ref=feature_azr-14" # ref=<release_version>
    project_ident       = var.project_ident
    env_ident           = var.env_ident
    region_suffix       = var.region_suffix
    resource_group_name = data.azurerm_resource_group.core-rg.name
    location            = data.azurerm_resource_group.core-rg.location
}

# # Build Network Watcher in each allowed region
# module "network-watcher" {
#   source              = "git::https://gitlabcssdev.fan.gov/cpmo_azure/deployment_code.git//modules/networkWatcher?ref=feature_azr-14" # ref=<release_version>
#   location            = "${var.region}" # Map Variable used to build in each region, for monitoring
#   resource_group_name = azurerm_resource_group.test.name
# }
