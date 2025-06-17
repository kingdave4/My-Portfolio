resource "azurerm_static_web_app" "static_site" {
  name                = var.static_site_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_tier            = "Free"
  sku_size            = "Free"
}
