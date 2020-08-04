
output "vnet_id" {
  value = "${azurerm_virtual_network.vnet.id}"
}

output "vnet_name" {
  value = "${azurerm_virtual_network.vnet.name}"
}

output "vnet_address_prefix" {
  value = "${azurerm_virtual_network.vnet.address_space.0}"
}

output "sn1_name" {
  value = "${azurerm_subnet.sub1.name}"
}

output "sn2_name" {
  value = "${azurerm_subnet.sub2.name}"
}

output "sn3_name" {
  value = "${azurerm_subnet.sub3.name}"
}

output "sn4_name" {
  value = "${azurerm_subnet.sub4.name}"
}

output "sn5_name" {
  value = "${azurerm_subnet.sub5.name}"
}

output "sn1_address_prefix" {
  value = "${azurerm_subnet.sub1.address_prefix}"
}

output "sn2_address_prefix" {
  value = "${azurerm_subnet.sub2.address_prefix}"
}

output "sn3_address_prefix" {
  value = "${azurerm_subnet.sub3.address_prefix}"
}

output "sn4_address_prefix" {
  value = "${azurerm_subnet.sub4.address_prefix}"
}

output "sn5_address_prefix" {
  value = "${azurerm_subnet.sub5.address_prefix}"
}

output "sn1_id" {
  value = "${azurerm_subnet.sub1.id}"
}

output "sn2_id" {
  value = "${azurerm_subnet.sub2.id}"
}

output "sn3_id" {
  value = "${azurerm_subnet.sub3.id}"
}

output "sn4_id" {
  value = "${azurerm_subnet.sub4.id}"
}

output "sn5_id" {
  value = "${azurerm_subnet.sub5.id}"
}
