terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  version = ">= 3.0.0"
}

provider "azuread" {
  version = ">= 2.0.0"
}

# Retrieve subscription ID using the azurerm_subscription data source
data "azurerm_subscription" "primary" {
  subscription_id = var.subscription_id
}

data "azuread_group" "example" {
  display_name     = "EJS-RGContributors"
  security_enabled = true
}

resource "azurerm_role_assignment" "example" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_group.example.object_id
}