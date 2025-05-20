output "sendgrid_api_key" {
  value = azurerm_key_vault_secret.my_sendgrid_api_key.value
}