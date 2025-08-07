terraform {
  required_version = ">= 1.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "azure_bastion" {
  source = "../module/"
  
  # Basic configuration
  bastion_name         = var.bastion_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  
  # Subnet configuration
  create_bastion_subnet = var.create_bastion_subnet
  bastion_subnet_cidr   = var.bastion_subnet_cidr
  
  # Bastion configuration
  bastion_sku  = var.bastion_sku
  scale_units  = var.scale_units
  
  # Advanced features
  copy_paste_enabled        = var.copy_paste_enabled
  file_copy_enabled         = var.file_copy_enabled
  ip_connect_enabled        = var.ip_connect_enabled
  kerberos_enabled          = var.kerberos_enabled
  shareable_link_enabled    = var.shareable_link_enabled
  tunneling_enabled         = var.tunneling_enabled
  session_recording_enabled = var.session_recording_enabled
  
  # Network configuration
  public_ip_sku      = var.public_ip_sku
  availability_zones = var.availability_zones
  create_nsg         = var.create_nsg
  
  # Tags
  tags = var.tags
}
