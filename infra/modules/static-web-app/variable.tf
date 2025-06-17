variable "resource_group_name" {
  description = "The name of the resource group where the static web app will be created."
  type        = string
}

variable "location" {
  description = "Azure region for the resources."
  type        = string
}


variable "static_site_name" {
  description = "Name of the static web app."
  type        = string
}