terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.62.0"
    }
  }

  backend "azurerm" {
    // Backend configuration is in ../variables/{env}.init files
    // terraform init needs to be run with parameter -backend-config=../variables/{env}.init
  }
}

provider "azurerm" {
  features {}
}