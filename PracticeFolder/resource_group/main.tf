variable "rg_val" {}

resource "azurerm_resource_group" "rg-block" {
for_each = var.rg_val
name = each.value.name
location = each.value.location
}