terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }
 
  # Keep Terraform's state in the storage account from Part 2.
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "<your-state-storage-account-name>"
    container_name       = "tfstate"
    key                  = "novapay.tfstate"
  }
}
 
provider "azurerm" {
  features {}
}
