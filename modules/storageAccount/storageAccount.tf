# resource "azurerm_storage_account" "storage-account-1" {}
# resource "azurerm_storage_container" "container-1" {}

resource "azurerm_storage_account" "storage-account-1" {
  name                     = "${var.sa_prefix}${var.env_ident}tfstate${var.region_suffix}"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "RAGRS"

  tags = {
    environment = "${var.project_ident}-${var.env_ident}"
  }
}

resource "azurerm_storage_container" "container-1" {
  name                  = "terraform-state-${var.project_ident}-${var.env_ident}"
  storage_account_name  = azurerm_storage_account.storage-account-1.name
  container_access_type = "blob"
  depends_on            = [azurerm_storage_account.storage-account-1]
  # Sets access to Blob anonymous, for CSE
 }

resource "azurerm_storage_container" "container-2" {
  name                  = "${var.project_ident}-${var.env_ident}-deployment-scripts"
  storage_account_name  = azurerm_storage_account.storage-account-1.name
  container_access_type = "blob"
  depends_on            = [azurerm_storage_account.storage-account-1]
  # Sets access to Blob anonymous, for CSE
 }
