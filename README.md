# Terraform Examples

A collection of reusable Terraform modules and deployment examples for Azure infrastructure.

## 📁 Project Structure

```
terraform_examples/
├── modules/                    # Reusable Terraform modules
│   ├── azure-bastion/         # Azure Bastion Host module
│   └── azure-windows-vm/      # Windows VM module
├── deployments/               # Example deployments
│   ├── bastion/              # Bastion deployment example
│   └── vm/                   # VM deployment example
└── README.md
```

## 🚀 Quick Start

### Prerequisites
- Azure CLI installed and configured
- Terraform installed (v1.0+)
- PowerShell (for Windows users)

### Deploy Azure Bastion
```bash
cd deployments/bastion
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

### Deploy Windows VMs
```bash
cd deployments/vm
terraform init
terraform plan -var-file="vm.tfvars"
terraform apply -var-file="vm.tfvars"
```

## 🛠 Modules

### Azure Bastion (`modules/azure-bastion`)
- Creates Azure Bastion Host with NSG rules
- Supports Standard/Premium SKUs with advanced features
- Configurable subnet creation or existing subnet usage

### Windows VM (`modules/azure-windows-vm`)
- Deploys multiple Windows Server 2022 VMs
- Per-VM resource group and location support
- Per-VM VNet configuration (create new or use existing)
- Private IP only (no public IPs)

## 🔧 Configuration Examples

### Multiple VMs with Different Networks
```hcl
vms = {
  "vm1" = {
    vm_name = "vm-home-gateway"
    network_config = {
      create_vnet = false
      vnet_name   = "existing-vnet"
      subnet_name = "subnet1"
    }
  }
  "vm2" = {
    vm_name = "vm-dev-server"
    network_config = {
      create_vnet             = true
      vnet_name               = "new-vnet"
      subnet_name             = "new-subnet"
      vnet_address_space      = ["10.1.0.0/16"]
      subnet_address_prefixes = ["10.1.1.0/24"]
    }
  }
}
```

## 🔐 Security Features

- **Azure Bastion**: Secure RDP/SSH access without public IPs
- **NSG Rules**: Configured for Azure Bastion requirements
- **Private VMs**: No direct internet access
- **Resource Isolation**: Support for cross-resource group deployments

## 📝 Notes

- VMs are designed to be accessed via Azure Bastion
- All `.tfvars` files are gitignored for security
- Supports both new and existing VNet scenarios
- Cross-region and cross-resource group deployments supported

## 🆘 Common Commands

```bash
# Initialize Terraform
terraform init

# Plan deployment
terraform plan -var-file="<your-vars-file>"

# Apply changes
terraform apply -var-file="<your-vars-file>"

# Destroy resources
terraform destroy -var-file="<your-vars-file>"
```