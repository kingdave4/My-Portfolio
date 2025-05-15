# Create the azure resource Group
resource "azurerm_resource_group" "rg" {
  name     = "static-web-app-rg"
  location = var.location
}

# Create the azure static Web App
resource "azurerm_static_web_app" "static_site" {
  name                = var.static_site_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_tier            = "Free"
  sku_size            = "Free"
}

resource "azurerm_storage_account" "" {
  name                    = "mystorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}