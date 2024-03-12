resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = {
    terraform = "true"
  }
}