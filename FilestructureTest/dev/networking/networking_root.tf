terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "satfstate109234"
    container_name       = "tfstate"
    key                  = "FilestructureTest/dev/networking/terraform.tfstate"
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

data "terraform_remote_state" "rg"{
    backend = "azurerm"

    config = {
        resource_group_name  = "rg-tfstate"
        storage_account_name = "satfstate109234"
        container_name       = "tfstate"
        key                  = "FilestructureTest/dev/rg/terraform.tfstate"
    }
}

locals{
  vnet_name = "vnet1"
}


module "vnet" {
  source = "../../modules/modules/vnet"

  resource_group_name = data.terraform_remote_state.rg.outputs.resource_group_name
  location = data.terraform_remote_state.rg.outputs.location
  vnet_name  = local.vnet_name
  address_space = ["10.0.0.0/16"]
}

module "snet1" {
  source = "../../modules/modules/subnet"

  snet_name = "snet1"
  resource_group_name = data.terraform_remote_state.rg.outputs.resource_group_name
  vnet_name  = local.vnet_name
  address_prefixes = ["10.0.1.0/24"]
}
