# terraform {
#   required_providers {
#     azurerm = {
#       # source  = "hashicorp/azurerm"
#       # version = "4.3.0"
#     }
#   }
# }

# provider "azurerm" {
#   features {
#     # key_vault {
#     #   purge_soft_delete_on_destroy    = true
#     #   recover_soft_deleted_key_vaults = true
#     # }
#   }
#   subscription_id = "35b8656f-c121-4787-97b7-ea9d0892e5e9"
# }



terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0"
    }
  }
}

provider "azurerm" {
  features {}
  
  subscription_id = "35b8656f-c121-4787-97b7-ea9d0892e5e9"

}