variable "rg-var" {}

resource "azurerm_resource_group" "rg-block" {
  for_each = var.rg-var
  name     = each.value.name
  location = each.value.location
}
