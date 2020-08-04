
# Public Subnets NSG
resource "azurerm_network_security_group" "nsg1" {
  name                = "${var.project_ident}-${var.env_ident}-${var.nsg1_name}-${var.region_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_subnet.sub1]
}

resource "azurerm_network_security_rule" "nsg1rule1" {
  name                         = "RDPInbound"
  priority                     = 100
  description                  = "Used to remotely access Windows VMs"
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "TCP"
  source_port_range            = "*"
  destination_port_range       = "3389"
  source_address_prefix        = azurerm_virtual_network.vnet.address_space.0
  destination_address_prefixes = ["${azurerm_subnet.sub1.address_prefix}","${azurerm_subnet.sub2.address_prefix}","${azurerm_subnet.sub3.address_prefix}","${azurerm_subnet.sub4.address_prefix}","${azurerm_subnet.sub5.address_prefix}","${azurerm_subnet.sub6.address_prefix}"]
  #destination_address_prefix  = "${azurerm_subnet.sub1.address_prefix}" 
  resource_group_name          = var.resource_group_name
  network_security_group_name  = azurerm_network_security_group.nsg1.name
}

resource "azurerm_network_security_rule" "nsg1rule2" {
  name                         = "SSHInbound"
  priority                     = 110
  description                  = "Used to remotely access Linux VMs"
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "TCP"
  source_port_range            = "*"
  destination_port_range       = "22"
  source_address_prefix        = azurerm_virtual_network.vnet.address_space.0
  destination_address_prefixes = ["${azurerm_subnet.sub1.address_prefix}","${azurerm_subnet.sub2.address_prefix}","${azurerm_subnet.sub3.address_prefix}","${azurerm_subnet.sub4.address_prefix}","${azurerm_subnet.sub5.address_prefix}","${azurerm_subnet.sub6.address_prefix}"]
  #destination_address_prefix  = "${azurerm_subnet.sub1.address_prefix}" 
  resource_group_name          = var.resource_group_name
  network_security_group_name  = azurerm_network_security_group.nsg1.name
}

# Private App Subnets NSG
resource "azurerm_network_security_group" "nsg2" {
  name                = "${var.project_ident}-${var.env_ident}-${var.nsg2_name}-${var.region_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  depends_on           = [azurerm_subnet.sub2]
}

# Private DB Subnets NSG
resource "azurerm_network_security_group" "nsg3" {
  name                = "${var.project_ident}-${var.env_ident}-${var.nsg3_name}-${var.region_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  depends_on           = [azurerm_subnet.sub3]
}

# resource "azurerm_network_security_group" "nsg5" {
#   name                = "${var.project_ident}-${var.env_ident}-${var.nsg5_name}-${var.region_suffix}"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   depends_on           = [azurerm_subnet.sub5]
# }

# resource "azurerm_network_security_group" "nsg6" {
#   name                = "${var.project_ident}-${var.env_ident}-${var.nsg5_name}-${var.region_suffix}"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   depends_on           = [azurerm_subnet.sub6]
# }

