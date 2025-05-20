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

variable "sendgrid_api_key" {
  description = "SendGrid API key for email notifications."
  type        = string
  sensitive   = true
}