provider "azurerm" {
  features {}
}

module "windows_vm" {
  source              = "../module/"
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  # rdp_port            = var.rdp_port
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.subnet_id
  vnet_name           = var.vnet_name
}

# output "windows_vm_public_ip" {
#   value = module.windows_vm.public_ip_address
# }
