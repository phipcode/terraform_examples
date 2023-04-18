variable "resource_group_name" {
  description = "The name of the resource group to create the virtual machine in"
}

variable "location" {
  description = "The location to create the virtual machine in"
}

variable "vm_name" {
  description = "The name of the virtual machine"
  default     = "my-windows-vm"
}

variable "vm_size" {
  description = "The size of the virtual machine"
  default     = "Standard_DS1_v2"
}

variable "admin_username" {
  description = "The username for the virtual machine's administrator account"
  default     = "myadminuser"
}

variable "admin_password" {
  description = "The password for the virtual machine's administrator account"
  default     = "myadminpassword"
}

variable "rdp_port" {
  description = "The port used for RDP traffic"
  default     = 3389
}

variable "subnet_id" {
  description = "The ID of the subnet to create the virtual machine in"
}

variable "vnet_name" {
  description = "The name of the VNet to create the virtual machine in"
}
