# Azure Bastion Terraform Module

This repository contains a complete Azure Bastion module following Terraform best practices.

## Module Structure

```
azure-bastion/
├── module/                 # Reusable module
│   ├── main.tf            # Main resources
│   ├── variables.tf       # Input variables
│   ├── outputs.tf         # Output values
│   └── README.md          # Module documentation
└── bastion/               # Implementation example
    ├── main.tf            # Module usage
    ├── variables.tf       # Implementation variables
    ├── outputs.tf         # Implementation outputs
    └── bastion.tfvars     # Example values
```

## Quick Start

1. **Update the variables file**: Edit `bastion/bastion.tfvars` with your specific values:
   ```hcl
   bastion_name         = "your-bastion"
   location             = "your-region"
   resource_group_name  = "your-rg"
   virtual_network_name = "your-vnet"
   ```

2. **Initialize Terraform**:
   ```bash
   cd bastion/
   terraform init
   ```

3. **Plan the deployment**:
   ```bash
   terraform plan -var-file="bastion.tfvars"
   ```

4. **Apply the configuration**:
   ```bash
   terraform apply -var-file="bastion.tfvars"
   ```

## Features

- ✅ **Complete Azure Bastion setup** with public IP and subnet
- ✅ **Flexible subnet management** (create new or use existing)
- ✅ **Security-focused** with proper NSG rules
- ✅ **Multi-SKU support** (Developer, Basic, Standard, Premium)
- ✅ **Advanced features** for Standard/Premium SKUs
- ✅ **Zone-redundant** public IP support
- ✅ **Comprehensive tagging**
- ✅ **Input validation** for critical parameters

## Example Configurations

### Development Environment
```hcl
bastion_sku            = "Basic"
copy_paste_enabled     = true
file_copy_enabled      = false
create_nsg             = true
```

### Production Environment
```hcl
bastion_sku            = "Standard"
scale_units            = 4
file_copy_enabled      = true
ip_connect_enabled     = true
tunneling_enabled      = true
session_recording_enabled = false
```

### Enterprise Environment
```hcl
bastion_sku               = "Premium"
scale_units               = 10
session_recording_enabled = true
kerberos_enabled          = true
```

## Prerequisites

- Azure subscription with appropriate permissions
- Existing resource group
- Existing virtual network (or create new subnet)
- Terraform >= 1.0
- Azure CLI or service principal authentication

## Cost Considerations

| SKU | Base Cost | Scale Units | Best For |
|-----|-----------|-------------|----------|
| Developer | Lowest | Fixed | Development/Testing |
| Basic | Low | 2 units | Small environments |
| Standard | Medium | 2-50 units | Production workloads |
| Premium | Highest | 2-50 units | Enterprise with compliance |

## Security Features

- **Network Security Group**: Pre-configured with Azure Bastion required rules
- **Private Access**: Secure RDP/SSH without public IPs on VMs
- **Session Recording**: Available with Premium SKU
- **Multi-factor Authentication**: Integration with Azure AD
- **Just-in-Time Access**: When combined with Azure Security Center

## Troubleshooting

1. **Subnet Requirements**: Ensure AzureBastionSubnet is at least /26
2. **NSG Rules**: Use provided NSG or ensure proper rules are configured
3. **SKU Limitations**: Advanced features require Standard/Premium SKU
4. **Regional Availability**: Check Azure Bastion availability in your region

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the changes
5. Submit a pull request

## Support

For issues and questions:
- Check the [Azure Bastion documentation](https://docs.microsoft.com/en-us/azure/bastion/)
- Review [Terraform AzureRM provider documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host)
- Open an issue in this repository
