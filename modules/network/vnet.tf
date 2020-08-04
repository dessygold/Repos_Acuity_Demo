
resource "azurerm_network_ddos_protection_plan" "vnet-ddos-plan" {
  name                ="${var.project_ident}-${var.env_ident}-vnet-ddos-plan-${var.region_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project_ident}-${var.env_ident}-vnet-${var.region_suffix}"
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.vnet-ddos-plan.id
    enable = true
  }

  tags                = {
                        owner = "se-azure"
                        environment = "${var.project_ident}-${var.env_ident}"
                      }
}

resource "azurerm_subnet" "sub1" {
  name                 = "${var.project_ident}-${var.env_ident}-${var.subnet1_name}-${var.region_suffix}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${var.subnet1_network}"]
  #service_endpoints    = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Sql"]
}

# NSG: DMZ SSH and RDP from VNET
resource "azurerm_subnet_network_security_group_association" "sub1-nsg" {
  subnet_id                 = azurerm_subnet.sub1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
  depends_on             = [azurerm_network_security_group.nsg1]
}

# ## NatGW Association for DMZ A Subnet
# resource "azurerm_subnet_nat_gateway_association" "sub1-natgw" {
#   subnet_id      = azurerm_subnet.sub1.id
#   nat_gateway_id = azurerm_nat_gateway.natgw-1.id
# }

resource "azurerm_subnet" "sub2" {
  name                 = "${var.project_ident}-${var.env_ident}-${var.subnet2_name}-${var.region_suffix}"
  resource_group_name  = var.resource_group_name  
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes       = ["${var.subnet2_network}"]
  #service_endpoints    = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Sql"]
}

# NSG: App Subnets
resource "azurerm_subnet_network_security_group_association" "sub2-nsg" {
  subnet_id                 = azurerm_subnet.sub2.id
  network_security_group_id = azurerm_network_security_group.nsg2.id
  depends_on             = [azurerm_network_security_group.nsg1]
}

resource "azurerm_subnet" "sub3" {
  name                      = "${var.project_ident}-${var.env_ident}-${var.subnet3_name}-${var.region_suffix}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  address_prefixes          = ["${var.subnet3_network}"]
}

# NSG: DB Subnets
resource "azurerm_subnet_network_security_group_association" "sub3-nsg" {
  subnet_id                 = azurerm_subnet.sub3.id
  network_security_group_id = azurerm_network_security_group.nsg3.id
  depends_on           = [azurerm_network_security_group.nsg3]
}

resource "azurerm_subnet" "sub4" {
  name                      = "${var.project_ident}-${var.env_ident}-${var.subnet4_name}-${var.region_suffix}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet.name
    address_prefixes        = ["${var.subnet4_network}"]
  #service_endpoints         = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Sql"]
}

# NSG: DMZ SSH and RDP from VNET
resource "azurerm_subnet_network_security_group_association" "sub4-nsg" {
  subnet_id                 = azurerm_subnet.sub4.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
  depends_on           = [azurerm_network_security_group.nsg1]
}

# ## NatGW Association for DMZ A Subnet
# resource "azurerm_subnet_nat_gateway_association" "sub4-natgw" {
#   subnet_id      = azurerm_subnet.sub4.id
#   nat_gateway_id = azurerm_nat_gateway.natgw-1.id
# }

resource "azurerm_subnet" "sub5" {
  name                      = "${var.project_ident}-${var.env_ident}-${var.subnet5_name}-${var.region_suffix}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  address_prefixes          = ["${var.subnet5_network}"]
  #service_endpoints         = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Sql"]
}

# NSG: App Subnets
resource "azurerm_subnet_network_security_group_association" "sub5-nsg" {
  subnet_id                 = azurerm_subnet.sub5.id
  network_security_group_id = azurerm_network_security_group.nsg2.id
  depends_on                = [azurerm_network_security_group.nsg2]
}

resource "azurerm_subnet" "sub6" {
  name                      = "${var.project_ident}-${var.env_ident}-${var.subnet6_name}-${var.region_suffix}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  address_prefixes          = ["${var.subnet6_network}"]
  #service_endpoints         = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Sql"]
}

# NSG: DB Subnets
resource "azurerm_subnet_network_security_group_association" "sub6-nsg" {
  subnet_id                 = azurerm_subnet.sub6.id
  network_security_group_id = azurerm_network_security_group.nsg3.id
  depends_on                = [azurerm_network_security_group.nsg3]
}
