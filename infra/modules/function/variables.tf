#Storage account name
variable "storage_account_name" {
  description = "Name of the storage account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the storage account will be created."
  type        = string
}

variable "location" {
  description = "Azure region for the resources."
  type        = string
}

variable "prefix" {
  description = "Prefix for the storage account name."
  type        = string
}

variable "storage_account_connection_string" {
  description = "Connection string for the storage account."
  type        = string
}

variable "storage_account_access_key" {
  description = "Access key for the storage account."
  type        = string
}

variable "app_insights_instrumentation_key" {
  description = "Instrumentation key for Application Insights."
  type        = string
}

variable "sendgrid_api_key" {
  description = "SendGrid API key for email notifications."
  type        = string
  sensitive   = true
}
