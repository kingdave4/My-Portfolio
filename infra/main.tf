# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "static-web-app-rg"
  location = var.location
}

# Static Web App
resource "azurerm_static_web_app" "static_site" {
  name                = var.static_site_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_tier            = "Free"
  sku_size            = "Free"
}

#