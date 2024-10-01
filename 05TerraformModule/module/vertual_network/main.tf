
resource "azurerm_virtual_network" "vnet-block" {
  for_each            = var.vnet-create
  
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers
}