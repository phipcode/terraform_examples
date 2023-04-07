
#Australia Southeast - Non Prod

location            = "australiasoutheast"
resource_group_name = "terraform-examples-group2"
environment         = "nonprod"

#Network
virtual_networks = {
  example_vnet2 = {
    name                = "vnet-ause"
    address_space       = ["172.16.0.0/12"]
    location            = "australiasoutheast"
    resource_group_name = "terraform-examples-group2"
  }
}

subnets = {

  subnet1_ause = {
    name                       = "subnet1_ause"
    address_prefixes           = ["172.16.1.0/24"]
    virtual_network_name       = "vnet-ause"
    network_security_group_key = "nsg1_ause"
    resource_group_name        = "terraform-examples-group2"
  }

  subnet2_ause = {
    name                       = "subnet2_ause"
    address_prefixes           = ["172.16.2.0/24"]
    virtual_network_name       = "vnet-ause"
    network_security_group_key = "nsg2_ause"
    resource_group_name        = "terraform-examples-group2"
  }

}

network_security_groups = {
  nsg1_ause = {
    security_rule = [
      {
        name                                       = "allow_http"
        description                                = "Allow HTTP traffic"
        priority                                   = 100
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "80"
        source_address_prefix                      = "*"
        destination_address_prefix                 = "10.0.1.0/24"
        destination_application_security_group_ids = []
        source_application_security_group_ids      = []
      }
    ]
  },
  nsg2_ause = {
    security_rule = [
      {
        name                                       = "allow_ssh"
        description                                = "Allow SSH traffic"
        priority                                   = 110
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "22"
        source_address_prefix                      = "*"
        destination_address_prefix                 = "10.0.1.0/24"
        destination_application_security_group_ids = []
        source_application_security_group_ids      = []

      }
    ]
  }

  nsg3_ause = {
    security_rule = [
      {
        name                                       = "allow_rdp"
        description                                = "Allow RDP traffic"
        priority                                   = 120
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        destination_port_range                     = "3389"
        source_address_prefix                      = "*"
        destination_address_prefix                 = "10.0.1.0/24"
        destination_application_security_group_ids = []
        source_application_security_group_ids      = []

      }
    ]
  }
}
