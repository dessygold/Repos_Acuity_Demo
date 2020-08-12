# Create A Log Analytics Workspace 

# resource "azurerm_resource_group" "example" {
#   name     = "example-resources"
#   location = "East US"
# }

resource "azurerm_log_analytics_workspace" "laws" {
  name                = "${var.project_ident}-${var.env_ident}-laws-${var.region_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.laws_sku
  retention_in_days   = var.retention_in_days

  tags = {
    environment = "${var.project_ident}-${var.env_ident}"
  }
}