terraform {
  required_version = ">= 1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.43.0"
    }
  }
  cloud {

    organization = "FandTerra"

    workspaces {
      name = "TerraformCICD"
    }
  }
}


//provider config block
provider "azurerm" {
  features {}
  //skip_provider_registration = true
}

//declare data resource
data "azurerm_client_config" "current" {}

//existing resource
resource "azurerm_resource_group" "rg" {
  name     = "bicep-coursetest"
  location = "West US"
}

//create new resource
resource "azurerm_storage_account" "storage" {
  name                     = "storageacctfand3377"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
