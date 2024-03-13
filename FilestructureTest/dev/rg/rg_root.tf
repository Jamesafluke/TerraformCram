terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "satfstate109234"
    container_name       = "tfstate"
    key                  = "FilestructureTest/dev/rg/terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.94.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

module "rg" {
  # source   = "../../modules//modules/rg"
  source = "https://github.com/Jamesafluke/TerraformCram/tree/main/FilestructureTest/modules/modules/rg"
  location = "westus2"
  rg_name  = "rg_filestructureTest_dev"
}