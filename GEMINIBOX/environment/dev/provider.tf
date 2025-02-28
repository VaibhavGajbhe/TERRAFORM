

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.13.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "vg-rg" 
    storage_account_name = "pipestgacc001"                     
    container_name       = "statfilecontainer"                      
    key                  = "dev.terraform.tfstate"       
    use_azuread_auth     = true                           
  }
}

provider "azurerm" {
  features {}
  subscription_id = "1c7c7357-6d0d-4bd4-9401-0ecbf555933d"
}
