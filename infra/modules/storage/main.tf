resource "azurerm_storage_account" "my_storage_account" {
  name                     = "${var.prefix}storage"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account_static_website" "static" {
  storage_account_id = azurerm_storage_account.my_storage_account.id
  index_document     = "index.html"
  error_404_document = "404.html"
}
