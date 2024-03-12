terraform {
  cloud{
    organization = "jamesafluke"
    workspaces {
      name = "jf-workspace"
    }
    
  }
  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.94.0"
    }
  }
}

provider "azurerm" {
  features {}

    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
}


resource "azurerm_resource_group" "rg" {
    location = var.location
    name = var.rg_name
}