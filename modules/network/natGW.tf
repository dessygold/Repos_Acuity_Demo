
resource "azurerm_public_ip" "natgw-pip" {
  name                = "${var.project_ident}-${var.env_ident}-natgw-pip-${var.region_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_public_ip_prefix" "natgw-pip-prefix" {
  name                = "${var.project_ident}-${var.env_ident}-natgw-pip-prefix-${var.region_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  prefix_length       = 30
  zones               = ["1"]
}

resource "azurerm_nat_gateway" "natgw-1" {
  name                    = "${var.project_ident}-${var.env_ident}-natgw-${var.region_suffix}"
  location                = var.location
  resource_group_name     = var.resource_group_name
  #public_ip_address_ids   = [azurerm_public_ip.pip-1.id]
  public_ip_prefix_ids    = [azurerm_public_ip_prefix.natgw-pip-prefix.id]
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}

resource "azurerm_nat_gateway_public_ip_association" "example" {
  nat_gateway_id       = azurerm_nat_gateway.natgw-1.id
  public_ip_address_id = azurerm_public_ip.natgw-pip.id
}
