output "vm_ids" {
  description = "IDs of the created virtual machines"
  value       = { for k, v in azurerm_windows_virtual_machine.vms : k => v.id }
}

output "vm_private_ips" {
  description = "Private IP addresses of the created virtual machines"
  value       = { for k, v in azurerm_network_interface.vm_nic : k => v.ip_configuration[0].private_ip_address }
}

output "vnet_ids" {
  description = "IDs of the virtual networks (created and existing)"
  value = merge(
    { for k, v in azurerm_virtual_network.vm_vnets : k => v.id },
    { for k, v in data.azurerm_virtual_network.existing_vnets : k => v.id }
  )
}

output "subnet_ids" {
  description = "IDs of the subnets (created and existing)"
  value = merge(
    { for k, v in azurerm_subnet.vm_subnets : k => v.id },
    { for k, v in data.azurerm_subnet.existing_subnets : k => v.id }
  )
}
