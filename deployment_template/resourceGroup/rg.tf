# resource "azurerm_resource_group" "core-rg  " {
#   name     = "${var.project_ident}-${var.env_ident}-deployment-scripts"
#   location = "West Europe"
# }

# Resource group that will be imported into tf statefile and managed by terraform 
resource "azurerm_resource_group" "core-rg" {
   name      ="${var.project_ident}-${var.env_ident}-core-rg-${var.region_suffix}"
   location  ="eastus"
  
 }
