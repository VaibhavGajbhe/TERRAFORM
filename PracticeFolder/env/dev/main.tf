variable "getValue" {
  type = map(any)
}
variable "stgValue" {
  type = map(any)
}
module "create_rg" {
  source = "../../resource_group"
  rg_val = var.getValue
}
module "create_stg" {
    depends_on = [ module.create_rg ]
  source    = "../../storage_account"
  stg_value = var.stgValue
}