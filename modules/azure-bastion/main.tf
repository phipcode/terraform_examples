# Create public IP for Azure Bastion
resource "azurerm_public_ip" "bastion" {
  name                = "pip-${var.bastion_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = var.public_ip_sku
  zones               = var.availability_zones

  tags = merge(var.tags, {
    Name = "pip-${var.bastion_name}"
  })
}

# Create Azure Bastion subnet if not provided
resource "azurerm_subnet" "bastion" {
  count                = var.create_bastion_subnet ? 1 : 0
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.bastion_subnet_cidr]
}

# Get existing Bastion subnet if provided
data "azurerm_subnet" "bastion" {
  count                = var.create_bastion_subnet ? 0 : 1
  name                 = "AzureBastionSubnet"
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

# Create Network Security Group for Bastion subnet
resource "azurerm_network_security_group" "bastion" {
  count               = var.create_nsg ? 1 : 0
  name                = "nsg-${var.bastion_name}"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Inbound rules for Azure Bastion
  security_rule {
    name                       = "AllowMyPublicIP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "20.167.16.80/32"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHttpsInbound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowGatewayManagerInbound"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowAzureLoadBalancerInbound"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowBastionHostCommunication"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["8080", "5701"]
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  # Outbound rules for Azure Bastion
  security_rule {
    name                       = "AllowSshRdpOutbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "3389"]
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AllowSpecificSubnetAccess"
    priority                   = 105
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "3389"]
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.2.0/24"
  }

  security_rule {
    name                       = "AllowAzureCloudOutbound"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "AzureCloud"
  }

  security_rule {
    name                       = "AllowBastionCommunication"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["8080", "5701"]
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "AllowGetSessionInformation"
    priority                   = 130
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }

  tags = merge(var.tags, {
    Name = "${var.bastion_name}-nsg"
  })
}

# Associate NSG with Bastion subnet
resource "azurerm_subnet_network_security_group_association" "bastion" {
  count                     = var.create_nsg ? 1 : 0
  subnet_id                 = var.create_bastion_subnet ? azurerm_subnet.bastion[0].id : data.azurerm_subnet.bastion[0].id
  network_security_group_id = azurerm_network_security_group.bastion[0].id
}

# Create Azure Bastion Host
resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.bastion_sku
  scale_units         = var.scale_units

  copy_paste_enabled     = var.copy_paste_enabled
  file_copy_enabled      = var.file_copy_enabled
  ip_connect_enabled     = var.ip_connect_enabled
  kerberos_enabled       = var.kerberos_enabled
  shareable_link_enabled = var.shareable_link_enabled
  tunneling_enabled      = var.tunneling_enabled

  # For Developer SKU, use virtual_network_id instead of ip_configuration
  virtual_network_id = var.bastion_sku == "Developer" ? var.virtual_network_id : null

  # Only include ip_configuration for non-Developer SKUs
  dynamic "ip_configuration" {
    for_each = var.bastion_sku != "Developer" ? [1] : []
    content {
      name                 = "configuration"
      subnet_id            = var.create_bastion_subnet ? azurerm_subnet.bastion[0].id : (var.existing_subnet_id != null ? var.existing_subnet_id : data.azurerm_subnet.bastion[0].id)
      public_ip_address_id = azurerm_public_ip.bastion.id
    }
  }

  tags = merge(var.tags, {
    Name = var.bastion_name
  })

  depends_on = [azurerm_subnet_network_security_group_association.bastion]
}
