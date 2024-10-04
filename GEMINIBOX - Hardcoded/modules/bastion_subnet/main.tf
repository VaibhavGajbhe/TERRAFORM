
variable "bashion-var" {

}

resource "azurerm_subnet" "bash-block" {
  for_each             = var.bashion-var
  name                 = "AzureBastionSubnet"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}

