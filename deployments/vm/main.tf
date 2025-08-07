provider "azurerm" {
  features {}
}

module "windows_vms" {
  source = "../../modules/azure-windows-vm"
  
  # VM Configuration
  vms = var.vms
  
  # Default Resource Group and Location
  resource_group_name = var.resource_group_name
  location            = var.location
  
  # Tags
  tags = var.tags
}
