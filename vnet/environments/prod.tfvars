

#Australia Southeast -  Prod
location            = "australiaeast"
resource_group_name = "terraform-examples-group"
environment         = "prod"

#Network
virtual_networks = {
  example_vnet = {
    name                = "vnet-aue"
    address_space       = ["10.0.0.0/16"]
    location            = "australiaeast"
    resource_group_name = "terraform-examples-group"
  }
}

subnets = {
  subnet1 = {
    name                       = "subnet1"
    address_prefixes           = ["10.0.1.0/24"]
    virtual_network_name       = "vnet-aue"
    network_security_group_key = "nsg1"
    resource_group_name        = "terraform-examples-group"
  }

  subnet2 = {
    name                       = "subnet2"
    address_prefixes           = ["10.0.2.0/24"]
    virtual_network_name       = "vnet-aue"
    network_security_group_key = "nsg1"
    resource_group_name        = "terraform-examples-group"
  }

}

network_security_groups = {
  nsg1 = {
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
  nsg2 = {
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
}
