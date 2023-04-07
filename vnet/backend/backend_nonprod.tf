terraform {
  backend "azurerm" {
    storage_account_name = "<storage account>"
    container_name       = "<container name>"
    key                  = "nonprod-terraform.tfstate"
    resource_group_name  = "<resouce group name"
    access_key           = "<access key>"
    }
  }
 
