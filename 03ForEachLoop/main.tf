resource "azurerm_resource_group" "rgs" {
  for_each = toset(var.rg-list-variable)
  name     = each.key
  location = "West Europe"
}