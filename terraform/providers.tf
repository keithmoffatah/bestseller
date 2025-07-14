terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.50"
    }
  }

  required_version = ">= 1.4.0"

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
