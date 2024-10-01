variable "vm" {
  
}
module "rg-Create" {
  source    = "../../module/resource_group"
  rg-Create = var.rg_map
}

module "stg-Create" {
  depends_on = [module.rg-Create]
  source     = "../../module/storage_account"
  stg_map    = var.stg_map
}
module "vnet-Create" {
  depends_on  = [module.rg-Create]
  source      = "../../module/vertual_network"
  vnet-create = var.vnet_map
}
module "subnet-Create" {
  depends_on    = [module.vnet-Create]
  source        = "../../module/subnet"
  subnet-Create = var.subnet_map
}

module "NIC-Create" {
  depends_on = [module.rg-Create]
  source     = "../../module/nic"
  nic-Create = var.nic_map
}
