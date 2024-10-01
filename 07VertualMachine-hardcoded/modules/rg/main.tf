resource "azurerm_resource_group" "rg-block"{
 for_each = var.var-rg
 name= each.value.name
 location=each.value.location
}