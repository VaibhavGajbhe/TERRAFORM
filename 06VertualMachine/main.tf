resource "azurerm_resource_group" "rg-block" {
  name     = "vm-create-rg"
  location = "West Europe"
}
resource "azurerm_public_ip" "pip" {
  depends_on          = [azurerm_resource_group.rg-block]
  name                = "acceptanceTestPublicIp1"
  resource_group_name = "vm-create-rg"
  location            = "West Europe"
  allocation_method   = "Static"
}
resource "azurerm_virtual_network" "vnet-block" {
  depends_on          = [azurerm_resource_group.rg-block]
  name                = "vmvnet"
  address_space       = ["10.0.0.0/16"]
  location            = "West Europe"
  resource_group_name = "vm-create-rg"
}

resource "azurerm_subnet" "subnet-block" {
  depends_on           = [azurerm_virtual_network.vnet-block]
  name                 = "vmsubnet"
  resource_group_name  = "vm-create-rg"
  virtual_network_name = "vmvnet"
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic" {
  depends_on          = [azurerm_virtual_network.vnet-block]
  name                = "vm-nic-card"
  location            = "West Europe"
  resource_group_name = "vm-create-rg"

  ip_configuration {
    name                          = "dhondupip"
    subnet_id                     = azurerm_subnet.subnet-block.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm-block" {
  depends_on                      = [azurerm_subnet.subnet-block]
  name                            = "frontendVM"
  resource_group_name             = "vm-create-rg"
  location                        = "West Europe"
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "test@11223344"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  #   admin_ssh_key {
  #     username   = "adminuser"
  #     public_key = file("~/.ssh/id_rsa.pub")
  #   }

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
