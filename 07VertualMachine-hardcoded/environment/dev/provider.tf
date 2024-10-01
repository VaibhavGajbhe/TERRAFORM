terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }

  }

}

provider "azurerm" {
  features {
  }
  subscription_id = "35b8656f-c121-4787-97b7-ea9d0892e5e9"
}
