data "azurerm_client_config" "current" {}

resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}

resource "azurerm_key_vault" "my_keyvault" {
  name                        = "${var.prefix}keyvault${random_string.suffix.result}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge"
    ]
  }
}

resource "azurerm_key_vault_secret" "my_mailgun_api_key" {
  name         = "MAILGUN-API-KEY"
  value        = var.mailgun_api_key
  key_vault_id = azurerm_key_vault.my_keyvault.id
}

resource "azurerm_key_vault_secret" "my_mailgun_domain" {
  name         = "MAILGUN-DOMAIN"
  value        = var.my_mailgun_domain
  key_vault_id = azurerm_key_vault.my_keyvault.id
}

resource "azurerm_key_vault_secret" "my_mailgun_from_email" {
  name         = "FROM-EMAIL"
  value        = var.my_mailgun_from_email
  key_vault_id = azurerm_key_vault.my_keyvault.id
}


resource "azurerm_key_vault_secret" "my_mailgun_to_email" {
  name         = "TO-EMAIL"
  value        = var.my_mailgun_to_email
  key_vault_id = azurerm_key_vault.my_keyvault.id
}

