variable "rg-details" {}
variable "vnet-details" {}
variable "vm-details" {}
# variable "nic-details" {}
variable "nsg-details" {}
variable "stg-details" {}
variable "keyvault-details" {}
variable "bashion-details" {}
# variable "loadbalancer-details" {}

module "rg-module" {
  source = "../../modules/resource_group"
  rg-var = var.rg-details
}

module "vnet-module" {
  depends_on = [module.rg-module]
  source     = "../../modules/vertual_network"
  vnet-var   = var.vnet-details
}

module "nsg-module" {
  depends_on = [var.rg-details]
  source     = "../../modules/network_security_group"
  nsg-var    = var.nsg-details
}
module "stg-acc-module" {
  depends_on = [var.rg-details]
  source     = "../../modules/storage_account"
  stg-var    = var.stg-details
}

module "vm-module" {
  depends_on = [module.rg-module, module.vnet-module]
  source     = "../../modules/vertual_machine"
  vm-var     = var.vm-details

}
module "bashion-module" {
  depends_on  = [var.rg-details, var.vnet-details]
  source      = "../../modules/bastion_subnet"
  bashion-var = var.bashion-details

}

module "keyvault-modeule" {
  depends_on   = [module.rg-module]
  source       = "../../modules/key_vault"
  keyvault-var = var.keyvault-details
}

# module "loadbalancer-module" {
#   depends_on = [var.rg-details]
#   source     = "../../modules/load_balancer"
#   lb-var     = var.loadbalancer-details
# }
