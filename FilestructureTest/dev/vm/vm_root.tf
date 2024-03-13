terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "satfstate109234"
    container_name       = "tfstate"
    key                  = "FilestructureTest/dev/vm/terraform.tfstate"
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

data "terraform_remote_state" "networking"{
    backend = "azurerm"

    config = {
        resource_group_name  = "rg-tfstate"
        storage_account_name = "satfstate109234"
        container_name       = "tfstate"
        key                  = "FilestructureTest/dev/networking/terraform.tfstate"
    }
}

module "vm" {
  source = "../../modules/modules/VM_Ubuntu_PIP"
  
  location = data.terraform_remote_state.rg.outputs.location
  resource_group_name = data.terraform_remote_state.rg.outputs.resource_group_name
  vm_name = "vm1"
  pip_name = "pip1"
  nic_name = "nic1"
  subnet_id = data.terraform_remote_state.networking.outputs.subnet_id
}

