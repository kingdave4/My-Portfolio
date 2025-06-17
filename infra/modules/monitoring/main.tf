# Monitoring tools for the azure function

resource "azurerm_log_analytics_workspace" "log" {
  name                = "${var.prefix}-log"  
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
}

resource "azurerm_application_insights" "appi" {
  name                = "${var.prefix}-appi"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.log.id
}

