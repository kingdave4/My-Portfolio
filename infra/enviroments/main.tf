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
  mailgun_api_key    = var.mailgun_api_key
  my_mailgun_domain  = var.my_mailgun_domain
  my_mailgun_from_email = var.my_mailgun_from_email
  my_mailgun_to_email = var.my_mailgun_to_email
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
  mailgun_api_key          = module.keyvault.mailgun_api_key
  my_mailgun_domain       = module.keyvault.my_mailgun_domain
  my_mailgun_from_email   = module.keyvault.my_mailgun_from_email
  my_mailgun_to_email     = module.keyvault.my_mailgun_to_email
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
