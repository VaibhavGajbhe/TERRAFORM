resource "azurerm_public_ip" "pip" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = "vm-create-rg"
  location            = "West Europe"
  allocation_method   = "Static"
}
resource "azurerm_network_interface" "nic" {
  for_each = var.nic-Create
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "dhondupip"
    subnet_id                     = azurerm_subnet.subnet-block[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[each.key].id
  }
}
