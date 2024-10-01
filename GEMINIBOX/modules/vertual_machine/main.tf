variable "vm-var" {
}


data "azurerm_subnet" "subnet" {
  for_each             = var.vm-var
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

# Public IP Address
resource "azurerm_public_ip" "pip-block" {
    for_each = var.vm-var
  name                = "myPublicIP"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  allocation_method   = "Static"   # Static IP allocation
  sku                 = "Standard"
}
resource "azurerm_network_interface" "nic-block" {
  for_each            = var.vm-var
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id           = azurerm_public_ip.pip-block[each.key].id
    
  }
}
# resource "azurerm_network_interface_security_group_association" "example" {
#   network_interface_id      = azurerm_network_interface.nic-block.id
#   network_security_group_id = var.nsg_id  # Passed from NSG module
# }

resource "azurerm_linux_virtual_machine" "vm-block" {
  for_each                        = var.vm-var
  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic-block[each.key].id
  ]


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
