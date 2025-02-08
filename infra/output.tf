# Output deployment token
output "static_site_api_token" {
  value       = azurerm_static_web_app.static_site.api_key
  sensitive   = true
}