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
  description = "CIDR block for the Bastion subnet (minimum /26)"
  type        = string
  default     = "10.0.1.0/26"
}

variable "bastion_sku" {
  description = "SKU of Azure Bastion"
  type        = string
  default     = "Standard"
}

variable "scale_units" {
  description = "Number of scale units for Azure Bastion"
  type        = number
  default     = 2
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

variable "public_ip_sku" {
  description = "SKU of the public IP address"
  type        = string
  default     = "Standard"
}

variable "availability_zones" {
  description = "Availability zones for the public IP"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}
