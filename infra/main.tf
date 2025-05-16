resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}


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

resource "azurerm_storage_account" "my_storage_account" {
  name                    = "${var.prefix}storage${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_service_plan" "my_service_plan" {
  name                = "${var.prefix}servicecplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type            = "linux"
  sku_name           = "B1"
}

resource "azurerm_linux_function_app" "my_func_app" {
  name                = "${var.prefix}funcapp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  storage_account_name       = azurerm_storage_account.my_storage_account.name
  storage_account_access_key = azurerm_storage_account.my_storage_account.primary_access_key
  service_plan_id            = azurerm_service_plan.my_service_plan.id
  https_only = true
  site_config {}
}




