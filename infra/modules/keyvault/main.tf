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

resource "azurerm_key_vault_secret" "my_sendgrid_api_key" {
  name         = "SENDGRID-API-KEY"
  value        = var.sendgrid_api_key
  key_vault_id = azurerm_key_vault.my_keyvault.id
}
