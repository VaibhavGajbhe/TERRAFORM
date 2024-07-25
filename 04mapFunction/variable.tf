variable "map-function" {
  type = map(any)
  default = {
    rg-map01-function = "ukwest"
    rg-map02-function = "centralindia"
    rg-map03-function = "centralindia"
  }
}
variable "map-storageaccountname" {
  type = map(any)
  default = {
    stg1 = {
      name                     = "storageaccountmap1"
      resource_group_name      = "rg-map01-function"
      location                 = "ukwest"
      account_tier             = "Standard"
      account_replication_type = "GRS"
    }
    stg2 = {
      name                     = "storageaccountmap2"
      resource_group_name      = "rg-map02-function"
      location                 = "ukwest"
      account_tier             = "Standard"
      account_replication_type = "GRS"
    }
  }
}
