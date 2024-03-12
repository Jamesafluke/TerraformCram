
resource "azurerm_public_ip" "pip" {
  name                = var.pip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method = "Static"

  tags = {
    terraform = "true"
  }
}


resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  tags = {
    terraform = "true"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.vm_name
  size                = var.size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  # admin_ssh_key {
  #   username = var.admin_username
  #   public_key = "21398723401987623"
  # }

  disable_password_authentication = false
  admin_password                  = var.admin_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    offer = "0001-com-ubuntu-server-focal"
    publisher = "Canonical"
    sku = "20_04-lts-gen2"
    version = "latest"
  }

  tags = {
    terraform = "true"
  }

    # connection {
    #   type = "ssh"
    #   user = "jfluckiger"
    #   password = "Super123!"
    #   host = azurerm_public_ip.pip.ip_address
    # }
    # provisioner "remote-exec" {
    # inline = [
    #   # "sudo add-apt-repository ppa:openjdk-r/ppa",
    #   # "sudo apt-get update",
    #   # "sudo apt install openjdk-11-jdk",
    #   "logger Hi mom!",
    #   "touch /var/HiMom",
    # ]
  # }
}



