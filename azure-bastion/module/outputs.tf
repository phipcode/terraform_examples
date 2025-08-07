output "bastion_id" {
  description = "ID of the Azure Bastion host"
  value       = azurerm_bastion_host.bastion.id
}

output "bastion_name" {
  description = "Name of the Azure Bastion host"
  value       = azurerm_bastion_host.bastion.name
}

output "bastion_fqdn" {
  description = "FQDN of the Azure Bastion host"
  value       = azurerm_bastion_host.bastion.dns_name
}

output "public_ip_address" {
  description = "Public IP address of the Azure Bastion host"
  value       = azurerm_public_ip.bastion.ip_address
}

output "public_ip_id" {
  description = "ID of the public IP address"
  value       = azurerm_public_ip.bastion.id
}

output "bastion_subnet_id" {
  description = "ID of the Bastion subnet"
  value       = var.create_bastion_subnet ? azurerm_subnet.bastion[0].id : data.azurerm_subnet.bastion[0].id
}

output "nsg_id" {
  description = "ID of the Network Security Group (if created)"
  value       = var.create_nsg ? azurerm_network_security_group.bastion[0].id : null
}
