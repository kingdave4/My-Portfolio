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

variable "mailgun_api_key" {
  description = "SendGrid API key for email notifications."
  type        = string
  sensitive   = true
}

variable "my_mailgun_domain" {
  description = "Mailgun domain for email notifications."
  type        = string
}
variable "my_mailgun_from_email" {
  description = "From email address for Mailgun."
  type        = string
}
variable "my_mailgun_to_email" {
  description = "To email address for Mailgun."
  type        = string
}