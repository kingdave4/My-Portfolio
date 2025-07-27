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

variable "mailgun_api_key" {
  description = "SendGrid API key for email notifications."
  type        = string
  sensitive   = true
}

variable "static_site_name" {
  description = "Name of the static site."
  type        = string
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

