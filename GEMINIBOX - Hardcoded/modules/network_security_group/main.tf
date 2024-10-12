variable "nsg-var" {}

resource "azurerm_network_security_group" "nsg-block" {
  for_each            = var.nsg-var
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "security_rule" {
    for_each = each.value.nsg-rule
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

}

# Output the NSG ID
# output "nsg_id" {
#   value = azurerm_network_security_group.nsg-block.id
# }