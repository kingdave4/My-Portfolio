output "mailgun_api_key" {
  value = azurerm_key_vault_secret.my_mailgun_api_key.value
}

output "my_mailgun_domain" {
  value = azurerm_key_vault_secret.my_mailgun_domain.value
 }

output "my_mailgun_from_email" {
  value = azurerm_key_vault_secret.my_mailgun_from_email.value
}

output "my_mailgun_to_email" {
  value = azurerm_key_vault_secret.my_mailgun_to_email.value
}
