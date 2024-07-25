terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.110.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-test-tf"            # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "statfileupload"        # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstatecontainer"      # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "dev.terraform.tfstate" # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-block02" {
  name     = "rg-test-tf"
  location = "Westus"
}

# resource "azurerm_storage_account" "storagedemoAccount" {
#   depends_on = [ azurerm_resource_group.rg-block02 ]    #Explicite way of using depedencies[storage account depends on RG]
#   name                     = "demostoragaccountt"
#   resource_group_name      = "rg-test-tf"
#   location                 = "Westus"
#   account_tier             = "Standard"
#   account_replication_type = "GRS"

# }
resource "azurerm_storage_account" "storagedemoAccount01" {
  name                     = "statfileupload"
  resource_group_name      = azurerm_resource_group.rg-block02.name
  location                 = azurerm_resource_group.rg-block02.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

}
