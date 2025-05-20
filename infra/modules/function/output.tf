output "function_app_name" {
  value = azurerm_linux_function_app.func.name
}

output "function_app_id" {
  value = azurerm_linux_function_app.func.id
}

output "function_app_default_hostname" {
  value = azurerm_linux_function_app.func.default_hostname
}