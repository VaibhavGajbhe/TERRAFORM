# RESOURCE GROUP USING MAP FUNCTION
resource "azurerm_resource_group" "rgs" {
  for_each = var.map-function
  name     = each.key
  location = each.value
}

# STORAGE ACCOUNT USING MAP FUNCTION
resource "azurerm_storage_account" "stg-account-using-map" {
  for_each                 = var.map-storageaccountname
  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}