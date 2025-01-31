# Resource Group
resource "azurerm_resource_group" "hugo_rg" {
  name     = "hugo-blog-rg"
  location = "East US"
}

# Storage Account
resource "azurerm_storage_account" "hugo_storage" {
  name                     = "myhugoblogstorage31"  # Change to a unique name
  resource_group_name      = azurerm_resource_group.hugo_rg.name
  location                 = azurerm_resource_group.hugo_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
}

