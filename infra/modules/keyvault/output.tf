output "mailgun_api_key" {
  value = azurerm_key_vault_secret.my_mailgun_api_key.value
}