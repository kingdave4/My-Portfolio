terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "storage" {
  source              = "./modules/storage"
  prefix              = var.prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

module "keyvault" {
  source              = "./modules/keyvault"
  prefix              = var.prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sendgrid_api_key    = var.sendgrid_api_key
}

module "function" {
  source              = "./modules/function"
  prefix              = var.prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  storage_account_name           = module.storage.storage_account_name
  storage_account_connection_string = module.storage.primary_connection_string
  storage_account_access_key     = module.storage.storage_account_access_key
  app_insights_instrumentation_key = module.monitoring.app_insights_key
  sendgrid_api_key              = module.keyvault.sendgrid_api_key
}

module "monitoring" {
  source              = "./modules/monitoring"
  prefix              = var.prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
}
# Create a static web app
resource "azurerm_static_web_app" "static_site" {
  name                = var.static_site_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_tier            = "Free"
  sku_size            = "Free"
}
