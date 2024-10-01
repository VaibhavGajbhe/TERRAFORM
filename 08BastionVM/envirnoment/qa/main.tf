module "rg-module" {
  source = "../../module/resource_group"
  rg-var = var.rg-details
}
module "vnet-module" {
  depends_on = [module.rg-module, var.rg-details]
  source     = "../../module/vnet"
  vnet-var   = var.vnet-details
}
module "subnet-module" {
  depends_on = [module.rg-module, module.vnet-module]
  source     = "../../module/subnet"
  subnet-var = var.subnet-details
}
