
output "vnet_id" {
  #value = "${azurerm_virtual_network.vnet.id}"
  value = module.network.vnet_id
}

output "vnet_name" {
  #value = "${azurerm_virtual_network.vnet.name}"
  value = module.network.vnet_name
}

output "vnet_address_prefix" {
  #value = "${azurerm_virtual_network.vnet.address_space.0}"
  value = module.network.vnet_address_prefix
}

output "sn1_name" {
  #value = "${azurerm_subnet.sub1.name}"
  value = module.network.sn1_name
}

output "sn2_name" {
  #value = "${azurerm_subnet.sub2.name}"
  value = module.network.sn2_name
}

output "sn3_name" {
  #value = "${azurerm_subnet.sub3.name}"
  value = module.network.sn3_name
}

output "sn4_name" {
  #value = "${azurerm_subnet.sub4.name}"
  value = module.network.sn4_name
}

output "sn5_name" {
  #value = "${azurerm_subnet.sub5.name}"
  value = module.network.sn5_name
}

output "sn1_address_prefix" {
  #value = "${azurerm_subnet.sub1.address_prefix}"
  value = module.network.sn1_address_prefix
}

output "sn2_address_prefix" {
  #value = "${azurerm_subnet.sub2.address_prefix}"
  value = module.network.sn2_address_prefix
}

output "sn3_address_prefix" {
  #value = "${azurerm_subnet.sub3.address_prefix}"
  value = module.network.sn3_address_prefix
}

output "sn4_address_prefix" {
  #value = "${azurerm_subnet.sub4.address_prefix}"
  value = module.network.sn4_address_prefix
}

output "sn5_address_prefix" {
  #value = "${azurerm_subnet.sub5.address_prefix}"
  value = module.network.sn5_address_prefix
}

output "sn1_id" {
  #value = "${azurerm_subnet.sub1.id}"
  value = module.network.sn1_id
}

output "sn2_id" {
  #value = "${azurerm_subnet.sub2.id}"
  value = module.network.sn2_id
}

output "sn3_id" {
  #value = "${azurerm_subnet.sub3.id}"
  value = module.network.sn3_id
}

output "sn4_id" {
  #value = "${azurerm_subnet.sub4.id}"
  value = module.network.sn4_id
}

output "sn5_id" {
  #value = "${azurerm_subnet.sub5.id}"
  value = module.network.sn5_id
}
