provider "azurerm" {
  environment     = "public"
  subscription_id = var.subscription_Id
  tenant_id       = var.tenant_id
  client_id       = var.tf_sp_appid
  client_secret   = var.tf_sp_secret
  version         = "2.20"
  features {
  }
}

data "azurerm_client_config" "current" {
} 

# data "azurerm_resource_group" "core-rg" {
#   name = "${var.project_ident}-${var.env_ident}-${var.core_rg_name}-${var.region_suffix}"
# }
