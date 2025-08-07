
resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  for_each = var.virtual_networks

  name                = each.value.name
  address_space       = each.value.address_space
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  depends_on = [
    azurerm_resource_group.this
  ]

}

resource "azurerm_subnet" "this" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes

  depends_on = [
    azurerm_virtual_network.this
  ]

}

resource "azurerm_network_security_group" "this" {
  for_each = var.network_security_groups

  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  security_rule = [
    for rules in each.value.security_rule : {
      name                                       = rules.name
      priority                                   = rules.priority
      direction                                  = rules.direction
      access                                     = rules.access
      protocol                                   = rules.protocol
      description                                = rules.description
      destination_application_security_group_ids = rules.destination_application_security_group_ids
      source_application_security_group_ids      = rules.source_application_security_group_ids
      source_port_range                          = lookup(rules, "source_port_range", null)
      source_port_ranges                         = lookup(rules, "source_port_ranges", null)
      destination_port_range                     = lookup(rules, "destination_port_range", null)
      destination_port_ranges                    = lookup(rules, "destination_port_ranges", null)
      destination_address_prefix                 = lookup(rules, "destination_address_prefix", null)
      destination_address_prefixes               = lookup(rules, "destination_address_prefixes", null)
      source_address_prefix                      = lookup(rules, "source_address_prefix", null)
      source_address_prefixes                    = lookup(rules, "source_address_prefixes", null)
    }
  ]
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = { for k, v in var.subnets : k => v if v.network_security_group_key != "" }

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.value.network_security_group_key].id


  depends_on = [
    azurerm_subnet.this,
    azurerm_network_security_group.this
  ]
}


