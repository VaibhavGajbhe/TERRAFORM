
module "rg-module" {
  source = "../../modules/azurerm-resource-group"
  rg-var = var.rg-details
}
module "stg-module" {
  depends_on = [ module.rg-module ]
  source = "../../modules/azurerm-storage-account"
  stg-var = var.stg-details
}
