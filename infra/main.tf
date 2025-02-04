# Resource Group
resource "azurerm_resource_group" "hugo_rg" {
  name     = "hugo-blog-rg"
  location = "East US"
}

# Storage Account
resource "azurerm_storage_account" "hugo_storage" {
  name                     = "myhugoblogstorage31"  # Change to a unique name
  resource_group_name      = azurerm_resource_group.hugo_rg.name
  location                 = azurerm_resource_group.hugo_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
}

# CDN Profile
resource "azurerm_cdn_profile" "hugo_cdn_profile" {
  name                = "hugo-cdn-profile"
  location            = azurerm_resource_group.hugo_rg.location
  resource_group_name = azurerm_resource_group.hugo_rg.name
  sku                 = "Standard_Microsoft"
}

# CDN Endpoint
resource "azurerm_cdn_endpoint" "hugo_cdn_endpoint" {
  name                = "hugo-cdn-endpoint"
  profile_name        = azurerm_cdn_profile.hugo_cdn_profile.name
  location            = azurerm_resource_group.hugo_rg.location
  resource_group_name = azurerm_resource_group.hugo_rg.name

  origin {
    name      = "hugo-storage-origin"
    host_name = azurerm_storage_account.hugo_storage.primary_web_host
  }
}

# Custom Domain with HTTPS
resource "azurerm_cdn_endpoint_custom_domain" "hugo_custom_domain" {
  name            = "hugo-custom-domain"
  cdn_endpoint_id = azurerm_cdn_endpoint.hugo_cdn_endpoint.id
  host_name       = "kingdavedevopsproject.ca" # Replace with your GoDaddy domain

  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
    tls_version      = "TLS12"
  }
}