resource "azurerm_subnet" "sub" {
  for_each             = var.subnet-var
  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet_name
  address_prefixes     = each.value.address_prefixes
}
resource "azurerm_network_security_group" "nsg" {
  for_each            = var.subnet-var
  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


}
resource "azurerm_subnet_network_security_group_association" "test2" {
  for_each                  = var.subnet-var
  subnet_id                 = azurerm_subnet.sub[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}
resource "azurerm_subnet" "sub2" {
  for_each = var.bas-var
  name                 = "AzureBastionSubnet"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet_name
  address_prefixes     = each.value.address_prefixes
}
