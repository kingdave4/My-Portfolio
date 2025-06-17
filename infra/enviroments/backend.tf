terraform {
  required_version = ">= 1.2.0"
  backend "azurerm" {
    resource_group_name  = "mycloud-rg-tfstate"
    storage_account_name = "mytfstatedev"
    container_name       = "myhugo-tfstate"
    key                  = "dev.terraform.tfstate"
  }
}


