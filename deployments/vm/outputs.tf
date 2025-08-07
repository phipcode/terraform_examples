output "vm_ids" {
  description = "IDs of the created virtual machines"
  value       = module.windows_vms.vm_ids
}

output "vm_private_ips" {
  description = "Private IP addresses of the created virtual machines"
  value       = module.windows_vms.vm_private_ips
}

output "vnet_ids" {
  description = "IDs of the virtual networks (per VM)"
  value       = module.windows_vms.vnet_ids
}

output "subnet_ids" {
  description = "IDs of the subnets (per VM)"
  value       = module.windows_vms.subnet_ids
}
