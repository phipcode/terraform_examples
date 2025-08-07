
# Create VNets for VMs that need new VNets
resource "azurerm_virtual_network" "vm_vnets" {
  for_each = {
    for vm_key, vm in var.vms : vm_key => vm
    if vm.network_config.create_vnet == true
  }

  name                = each.value.network_config.vnet_name
  address_space       = each.value.network_config.vnet_address_space
  location            = each.value.location != null ? each.value.location : var.location
  resource_group_name = each.value.resource_group_name != null ? each.value.resource_group_name : var.resource_group_name

  tags = var.tags
}

# Create subnets for VMs that need new VNets
resource "azurerm_subnet" "vm_subnets" {
  for_each = {
    for vm_key, vm in var.vms : vm_key => vm
    if vm.network_config.create_vnet == true
  }

  name                 = each.value.network_config.subnet_name
  resource_group_name  = each.value.resource_group_name != null ? each.value.resource_group_name : var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vm_vnets[each.key].name
  address_prefixes     = each.value.network_config.subnet_address_prefixes
}

# Data sources for existing VNets
data "azurerm_virtual_network" "existing_vnets" {
  for_each = {
    for vm_key, vm in var.vms : vm_key => vm
    if vm.network_config.create_vnet == false
  }

  name                = each.value.network_config.vnet_name
  resource_group_name = each.value.network_config.vnet_resource_group != null ? each.value.network_config.vnet_resource_group : (each.value.resource_group_name != null ? each.value.resource_group_name : var.resource_group_name)
}

# Data sources for existing subnets
data "azurerm_subnet" "existing_subnets" {
  for_each = {
    for vm_key, vm in var.vms : vm_key => vm
    if vm.network_config.create_vnet == false
  }

  name                 = each.value.network_config.subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnets[each.key].name
  resource_group_name  = each.value.network_config.vnet_resource_group != null ? each.value.network_config.vnet_resource_group : (each.value.resource_group_name != null ? each.value.resource_group_name : var.resource_group_name)
}

# Create NICs for each VM
resource "azurerm_network_interface" "vm_nic" {
  for_each            = var.vms
  name                = "${each.value.vm_name}-nic"
  location            = each.value.location != null ? each.value.location : var.location
  resource_group_name = each.value.resource_group_name != null ? each.value.resource_group_name : var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = each.value.network_config.create_vnet ? azurerm_subnet.vm_subnets[each.key].id : data.azurerm_subnet.existing_subnets[each.key].id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

# Create Windows VMs
resource "azurerm_windows_virtual_machine" "vms" {
  for_each            = var.vms
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name != null ? each.value.resource_group_name : var.resource_group_name
  location            = each.value.location != null ? each.value.location : var.location
  size                = each.value.vm_size
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password
  network_interface_ids = [
    azurerm_network_interface.vm_nic[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-datacenter-g2"
    version   = "latest"
  }

  tags = var.tags
}
