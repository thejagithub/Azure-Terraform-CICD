terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }

   backend "azurerm" {
    resource_group_name  = "Task9-Thejana-Development-RG"
    storage_account_name = "task9devstate"
    container_name       = "tfstate"
    key                  = "development.terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
  subscription_id = var.subscription_id
}