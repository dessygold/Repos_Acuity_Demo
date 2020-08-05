output "sa_1_name" {
  value = "${azurerm_storage_account.storage-account-1.name}"
}

output "sa_1_id" {
  value = "${azurerm_storage_account.storage-account-1.id}"
}

output "sa_1_con_1_name" {
  value = "${azurerm_storage_container.container-1.name}"
}

output "sa_1_con_2_name" {
  value = "${azurerm_storage_container.container-2.name}"
}

output "sa_1_con_1_id" {
  value = "${azurerm_storage_container.container-1.id}"
}

output "sa_1_con_2_id" {
  value = "${azurerm_storage_container.container-2.id}"
}

output "sa_1_prim_blob_ep" {
  value = "${azurerm_storage_account.storage-account-1.primary_blob_endpoint}"
}