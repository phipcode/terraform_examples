variable "bastion_name" {
  description = "Name of the Azure Bastion host"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network where Bastion will be deployed"
  type        = string
}

variable "create_bastion_subnet" {
  description = "Whether to create the AzureBastionSubnet or use an existing one"
  type        = bool
  default     = true
}

variable "bastion_subnet_cidr" {
  description = "CIDR block for the Bastion subnet (minimum /26, required when create_bastion_subnet is true)"
  type        = string
  validation {
    condition     = can(cidrhost(var.bastion_subnet_cidr, 0))
    error_message = "The bastion_subnet_cidr must be a valid CIDR block."
  }
}

variable "bastion_sku" {
  description = "SKU of Azure Bastion. Valid values: Developer, Basic, Standard, Premium"
  type        = string
  default     = "Basic"
  validation {
    condition     = contains(["Developer", "Basic", "Standard", "Premium"], var.bastion_sku)
    error_message = "Bastion SKU must be one of: Developer, Basic, Standard, Premium."
  }
}

variable "scale_units" {
  description = "Number of scale units for Azure Bastion (2-50, only applicable for Standard and Premium SKU)"
  type        = number
  default     = 2
  validation {
    condition     = var.scale_units >= 2 && var.scale_units <= 50
    error_message = "Scale units must be between 2 and 50."
  }
}

variable "public_ip_sku" {
  description = "SKU of the public IP address"
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Basic", "Standard"], var.public_ip_sku)
    error_message = "Public IP SKU must be either 'Basic' or 'Standard'."
  }
}

variable "availability_zones" {
  description = "Availability zones for the public IP"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "copy_paste_enabled" {
  description = "Enable copy/paste feature"
  type        = bool
  default     = true
}

variable "file_copy_enabled" {
  description = "Enable file copy feature (requires Standard or Premium SKU)"
  type        = bool
  default     = false
}

variable "ip_connect_enabled" {
  description = "Enable IP connect feature (requires Standard or Premium SKU)"
  type        = bool
  default     = false
}

variable "kerberos_enabled" {
  description = "Enable Kerberos authentication feature (requires Standard or Premium SKU)"
  type        = bool
  default     = false
}

variable "shareable_link_enabled" {
  description = "Enable shareable link feature (requires Standard or Premium SKU)"
  type        = bool
  default     = false
}

variable "tunneling_enabled" {
  description = "Enable tunneling feature (requires Standard or Premium SKU)"
  type        = bool
  default     = false
}


variable "create_nsg" {
  description = "Whether to create and associate NSG with Bastion subnet"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

variable "existing_subnet_id" {
  description = "ID of existing AzureBastionSubnet (required when create_bastion_subnet is false)"
  type        = string
  default     = null
}

variable "virtual_network_id" {
  description = "The ID of the Virtual Network for the Developer Bastion Host (required when sku is Developer)"
  type        = string
  default     = null
}


