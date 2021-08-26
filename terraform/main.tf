terraform {
  backend "azurerm" {
    resource_group_name  = "yqs-rg"
    storage_account_name = "yqstfstate26284"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "state-demo-secure" {
  name     = "state-demo"
  location = "francecentral"
}