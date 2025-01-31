# Outputs
output "storage_account_name" {
  value = azurerm_storage_account.hugo_storage.name
}

output "website_url" {
  value = azurerm_storage_account.hugo_storage.primary_web_endpoint
}
