variable "vnet-var" {}
# variable "subnets" {}

resource "azurerm_virtual_network" "vnet-block" {
  for_each            = var.vnet-var
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
  #   dns_servers         = ["10.0.0.4", "10.0.0.5"]

  dynamic "subnet" {
     for_each = each.value.subnets
    content {
      name             = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
    }
  }


  
  tags = {
    environment = "Production"
  }

}
