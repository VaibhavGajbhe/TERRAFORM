

variable "stg_value" {
}
resource "azurerm_storage_account" "stg-block" {
for_each = var.stg_value
  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}