output "bastion_id" {
  description = "ID of the Azure Bastion host"
  value       = module.azure_bastion.bastion_id
}

output "bastion_name" {
  description = "Name of the Azure Bastion host"
  value       = module.azure_bastion.bastion_name
}

output "bastion_fqdn" {
  description = "FQDN of the Azure Bastion host"
  value       = module.azure_bastion.bastion_fqdn
}

output "public_ip_address" {
  description = "Public IP address of the Azure Bastion host"
  value       = module.azure_bastion.public_ip_address
}

output "bastion_subnet_id" {
  description = "ID of the Bastion subnet"
  value       = module.azure_bastion.bastion_subnet_id
}

output "nsg_id" {
  description = "ID of the Network Security Group"
  value       = module.azure_bastion.nsg_id
}
