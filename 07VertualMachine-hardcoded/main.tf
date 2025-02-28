variable "nic-var" {
  default = "hardcodedvm"
}
resource "azurerm_resource_group" "rg-block" {
  name     = "rg-vm-frontend"
  location = "westus"
}
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet-block" {
  name                = "vmVnet01"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-block.location
  resource_group_name = azurerm_resource_group.rg-block.name
}

resource "azurerm_subnet" "sub-block" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg-block.name
  virtual_network_name = azurerm_virtual_network.vnet-block.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_public_ip" "pip-block" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.rg-block.name
  location            = azurerm_resource_group.rg-block.location
  allocation_method   = "Static"

  }

resource "azurerm_network_interface" "nic-block" {
  name                = "nic-${var.nic-var}"
  location            = azurerm_resource_group.rg-block.location
  resource_group_name = azurerm_resource_group.rg-block.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sub-block.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip-block.id
  }
}

resource "azurerm_linux_virtual_machine" "vm-block" {
  name                            = "vm-${var.nic-var}"
  resource_group_name             = azurerm_resource_group.rg-block.name
  location                        = azurerm_resource_group.rg-block.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "test@11223344"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic-block.id,
  ]

  # admin_ssh_key {
  #   username   = "adminuser"
  #   public_key = file("~/.ssh/id_rsa.pub")
  # }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
