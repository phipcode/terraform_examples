variable "vms" {
  description = "Map of VMs to create"
  type = map(object({
    vm_name             = string
    vm_size             = optional(string, "Standard_B2s")
    admin_username      = string
    admin_password      = string
    resource_group_name = optional(string, null) # If null, uses default resource_group_name
    location            = optional(string, null) # If null, uses default location
    
    # Network configuration per VM
    network_config = object({
      create_vnet      = optional(bool, false)
      vnet_name        = string
      subnet_name      = string
      vnet_resource_group = optional(string, null) # For existing VNets
      
      # Only used when create_vnet = true
      vnet_address_space = optional(list(string), ["10.0.0.0/16"])
      subnet_address_prefixes = optional(list(string), ["10.0.1.0/24"])
    })
  }))
}

variable "resource_group_name" {
  description = "Default resource group name (can be overridden per VM)"
  type        = string
}

variable "location" {
  description = "Default location (can be overridden per VM)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    environment = "dev"
    project     = "home-lab"
  }
}
