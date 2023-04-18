variable "terraform_workspace" {
  description = "The Terraform workspace to use"
  default     = "non-prod"
}
variable "network_security_groups" {
  description = "A map of network security group configurations"
  # type = map(object({
  #   security_rule = list(object({
  #     name                                       = string
  #     priority                                   = number
  #     direction                                  = string
  #     access                                     = string
  #     protocol                                   = string
  #     source_port_range                          = string
  #     destination_port_range                     = string
  #     source_address_prefix                      = string
  #     destination_address_prefix                 = string
  #     description                                = string
  #     destination_application_security_group_ids = list(string)
  #     source_application_security_group_ids      = list(string)
  #     source_port_ranges                         = list(string)
  #     destination_port_ranges                    = list(string)
  #     source_address_prefixes                    = list(string)
  #     destination_address_prefixes               = list(string)
  #   }))
  # }))
  type = any
}

variable "subnets" {
  type = map(object({
    name               = string
    address_prefixes   = list(string)
    virtual_network_name = string
    network_security_group_key = string
    resource_group_name  = string
    
  }))
}

variable "location" {
  description = "The Azure region to deploy resources in"
  type        = string
  default     = "australiaeast"
}


variable "resource_group_name" {
  description = "The name of the resource group to deploy resources in"
  type        = string
}

variable "virtual_networks" {
  description = "A map of virtual network configurations"
  type = map(object({
    name                = string
    address_space       = list(string)
    location            = string
    resource_group_name = string
  }))
  default = {}
}

variable "dns_servers" {
  description = "A list of DNS server IP addresses to use for the virtual network"
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "The environment to deploy to"
  type        = string
  default = ""
}