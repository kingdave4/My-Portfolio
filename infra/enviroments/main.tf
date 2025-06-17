# This file is part of the Terraform configuration for deploying a Hugo blog on Azure.

module "resource_group" {
  source = "../modules/resource-group"
  prefix = var.prefix
  location = var.location
}

module "storage" {
  source              = "../modules/storage"
  prefix              = var.prefix
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
}

module "keyvault" {
  source              = "../modules/keyvault"
  prefix              = var.prefix
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  sendgrid_api_key    = var.sendgrid_api_key
}

module "function" {
  source              = "../modules/function"
  prefix              = var.prefix
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  storage_account_name           = module.storage.storage_account_name
  storage_account_connection_string = module.storage.primary_connection_string
  storage_account_access_key     = module.storage.storage_account_access_key
  app_insights_instrumentation_key = module.monitoring.app_insights_key
  sendgrid_api_key              = module.keyvault.sendgrid_api_key
}

module "monitoring" {
  source              = "../modules/monitoring"
  prefix              = var.prefix
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
}

module "static_web_app" {
  source              = "../modules/static-web-app"
  static_site_name   = var.static_site_name
  location            =  module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  
}
