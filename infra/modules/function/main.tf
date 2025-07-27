resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}

resource "azurerm_service_plan" "svc-plan" {
  name                = "${var.prefix}-service-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "func" {
  name                       = "${var.prefix}-func${random_string.suffix.result}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  service_plan_id            = azurerm_service_plan.svc-plan.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      python_version = "3.11" # Use the version you need
    }
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME         = "python"
    APPINSIGHTS_INSTRUMENTATIONKEY   = var.app_insights_instrumentation_key
    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING = var.storage_account_connection_string
    MAILGUN_API_KEY                 = var.mailgun_api_key
    WEBSITE_CONTENTSHARE             = "content-${var.prefix}"
    AzureWebJobsStorage              = var.storage_account_connection_string
    MAILGUN_DOMAIN                  = var.my_mailgun_domain
    MAILGUN_FROM_EMAIL              = var.my_mailgun_from_email
    MAILGUN_TO_EMAIL                = var.my_mailgun_to_email
  }
}

