# Azure Bastion Terraform Module

This module creates an Azure Bastion host with all necessary components including public IP, subnet (optional), and network security group.

## Features

- **Flexible Subnet Management**: Can create a new AzureBastionSubnet or use an existing one
- **Security**: Includes proper NSG rules for Azure Bastion traffic
- **SKU Support**: Supports all Azure Bastion SKUs (Developer, Basic, Standard, Premium)
- **Advanced Features**: Configurable advanced features based on SKU
- **High Availability**: Zone-redundant public IP support
- **Tagging**: Comprehensive tagging support

## Usage

### Basic Usage

```hcl
module "bastion" {
  source                = "./module"
  bastion_name          = "my-bastion"
  location              = "Australia East"
  resource_group_name   = "rg-bastion"
  virtual_network_name  = "my-vnet"
  bastion_subnet_cidr   = "10.0.1.0/26"
}
```

### Advanced Usage with Standard SKU

```hcl
module "bastion" {
  source                = "./module"
  bastion_name          = "enterprise-bastion"
  location              = "Australia East"
  resource_group_name   = "rg-bastion"
  virtual_network_name  = "enterprise-vnet"
  
  # Subnet configuration
  create_bastion_subnet = true
  bastion_subnet_cidr   = "10.0.10.0/26"
  
  # Bastion configuration
  bastion_sku           = "Standard"
  scale_units           = 4
  
  # Advanced features (Standard/Premium only)
  file_copy_enabled     = true
  ip_connect_enabled    = true
  tunneling_enabled     = true
  kerberos_enabled      = true
  
  # Network configuration
  public_ip_sku         = "Standard"
  availability_zones    = ["1", "2", "3"]
  
  # Security
  create_nsg            = true
  
  tags = {
    Environment = "Production"
    Team        = "Platform"
    Purpose     = "Secure VM Access"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| azurerm | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.0 |

## Resources

| Name | Type |
|------|------|
| azurerm_bastion_host.bastion | resource |
| azurerm_public_ip.bastion | resource |
| azurerm_subnet.bastion | resource |
| azurerm_network_security_group.bastion | resource |
| azurerm_subnet_network_security_group_association.bastion | resource |
| azurerm_subnet.bastion | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bastion_name | Name of the Azure Bastion host | `string` | n/a | yes |
| location | Azure region where resources will be created | `string` | n/a | yes |
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| virtual_network_name | Name of the virtual network where Bastion will be deployed | `string` | n/a | yes |
| create_bastion_subnet | Whether to create the AzureBastionSubnet or use an existing one | `bool` | `true` | no |
| bastion_subnet_cidr | CIDR block for the Bastion subnet (minimum /26) | `string` | `"10.0.1.0/26"` | no |
| bastion_sku | SKU of Azure Bastion | `string` | `"Standard"` | no |
| scale_units | Number of scale units for Azure Bastion (2-50) | `number` | `2` | no |
| public_ip_sku | SKU of the public IP address | `string` | `"Standard"` | no |
| availability_zones | Availability zones for the public IP | `list(string)` | `["1", "2", "3"]` | no |
| copy_paste_enabled | Enable copy/paste feature | `bool` | `true` | no |
| file_copy_enabled | Enable file copy feature (requires Standard or Premium SKU) | `bool` | `false` | no |
| ip_connect_enabled | Enable IP connect feature (requires Standard or Premium SKU) | `bool` | `false` | no |
| kerberos_enabled | Enable Kerberos authentication feature (requires Standard or Premium SKU) | `bool` | `false` | no |
| shareable_link_enabled | Enable shareable link feature (requires Standard or Premium SKU) | `bool` | `false` | no |
| tunneling_enabled | Enable tunneling feature (requires Standard or Premium SKU) | `bool` | `false` | no |
| session_recording_enabled | Enable session recording feature (requires Premium SKU) | `bool` | `false` | no |
| create_nsg | Whether to create and associate NSG with Bastion subnet | `bool` | `true` | no |
| tags | A map of tags to assign to the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bastion_id | ID of the Azure Bastion host |
| bastion_name | Name of the Azure Bastion host |
| bastion_fqdn | FQDN of the Azure Bastion host |
| public_ip_address | Public IP address of the Azure Bastion host |
| public_ip_id | ID of the public IP address |
| bastion_subnet_id | ID of the Bastion subnet |
| nsg_id | ID of the Network Security Group (if created) |

## Prerequisites

- Azure subscription with appropriate permissions
- Virtual network (if not creating new subnet, must have AzureBastionSubnet with minimum /26 CIDR)
- Resource group

## SKU Comparison

| Feature | Developer | Basic | Standard | Premium |
|---------|-----------|-------|----------|---------|
| Copy/Paste | ✅ | ✅ | ✅ | ✅ |
| File Copy | ❌ | ❌ | ✅ | ✅ |
| IP Connect | ❌ | ❌ | ✅ | ✅ |
| Kerberos Auth | ❌ | ❌ | ✅ | ✅ |
| Shareable Links | ❌ | ❌ | ✅ | ✅ |
| Tunneling | ❌ | ❌ | ✅ | ✅ |
| Session Recording | ❌ | ❌ | ❌ | ✅ |
| Scale Units | Fixed | 2 | 2-50 | 2-50 |

## Best Practices

1. **Subnet Sizing**: Use at least /26 CIDR for AzureBastionSubnet
2. **Security**: Always use NSG with proper rules
3. **High Availability**: Use Standard public IP SKU with availability zones
4. **Monitoring**: Enable session recording for Premium SKU in production
5. **Cost Optimization**: Use Basic SKU for development/testing environments
6. **Naming**: Follow consistent naming conventions for all resources
