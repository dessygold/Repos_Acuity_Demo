resource "azurerm_resource_group" "core-rg  " {
  name     = "${var.project_ident}-${var.env_ident}-deployment-scripts"
  location = "West Europe"
}
