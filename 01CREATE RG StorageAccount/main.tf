terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.110.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "rg-state-fileupload"   # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
  #   storage_account_name = "tfstatetorage"         # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
  #   container_name       = "statefileupload"       # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
  #   key                  = "dev.terraform.tfstate" # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  # }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-tfstate-block" {
  name     = "rg-state-fileupload"
  location = "Westus"
}

# WE DELETE THIS RG AFTER COMMENTING IT AND RUN PLAN AND APPLY COMMANDS 
# DUE DO THIS TF STATE FILE ASLO UPDATED

# resource "azurerm_resource_group" "rg-test-block" {
#   name     = "rg-test-01"
#   location = "Westus"
# }

# DELETING THIS RG FROM PORTAL TO CHECK CHANGES AND STATE FILE

resource "azurerm_resource_group" "rg-delete-block" {
  name     = "rg-delete-from-portal"
  location = "Westus"
}

# resource "azurerm_storage_account" "storagedemoAccount" {
#  # depends_on = [ azurerm_resource_group.rg-block02 ]    #Explicite way of using depedencies[storage account depends on RG]
#   name                     = "demostoragaccountt"
#   resource_group_name      = "rg-test-tf"
#   location                 = "Westus"
#   account_tier             = "Standard"
#   account_replication_type = "GRS"

# }
resource "azurerm_storage_account" "storagedemoAccount01" {
  name                     = "tfstatetorage"
  resource_group_name      = azurerm_resource_group.rg-tfstate-block.name     #Implicite way of uding depedencies [using variable resourcegroup.rgblock.name]
  location                 = azurerm_resource_group.rg-tfstate-block.location #Implicite way
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
# CREATING CONTAINER IN STORAGE ACCOUNT IMPLICITLY
resource "azurerm_storage_container" "storagecontainer" {
  name                  = "statefileupload"
  storage_account_name  = azurerm_storage_account.storagedemoAccount01.name #IMPLICITE
  container_access_type = "private"
}