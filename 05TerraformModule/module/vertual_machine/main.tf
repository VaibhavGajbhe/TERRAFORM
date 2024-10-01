resource "azurerm_linux_virtual_machine" "vm-block" {
  for_each                        = var.vm-Create
  name                            = "frontendVm"
  resource_group_name             = "rg-create-map01"
  location                        = "japanwest"
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "test@11223344"
  disable_password_authentication = false
  network_interface_ids = [
  azurerm_network_interface.NIC-Block.ip]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

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
