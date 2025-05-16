# Define the variables for the location and the name of the static web app
variable "location" {
  description = "Azure region for the resources."
  type        = string
  default     = "eastus2"
}

# Define the name of the static web app
variable "static_site_name" {
  description = "Name for the Azure Static Web App."
  type        = string
  default     = "my-static-web-app"
}


variable "prefix" {
  description = "Prefix for the storage account name."
  type        = string
  default     = "myhugoblog" 
}

