module "vnet" {
  source = "../../modules/vnet"

  vnet_name           = "Task9-Thejana-Shared-Vnet"
  location            = data.azurerm_resource_group.shared.location
  resource_group_name = data.azurerm_resource_group.shared.name
  address_space       = "10.0.0.0/16"


  

  public_subnets = [
    {
      name = "Task9-Thejana-Shared-public-subnet"
      cidr = "10.0.1.0/24"
    }
  ]

  private_subnets = [
    {
      name = "Task9-Thejana-Shared-private-subnet"
      cidr = "10.0.2.0/24"
    }
  ]

  public_nsg_rules = [
    {
      name                       = "allow-vpn-udp"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "18857"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-pritunl-web"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-ssh-inbound"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-all-outbound"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]

  private_nsg_rules = [
    {
      name                       = "allow-ssh-from-vpn"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-jenkins-from-vpn"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "8080"
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "*"
    },
    {
      name                       = "deny-all-inbound"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-all-outbound"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]

  appgw_subnet = {
    name = "shared-appgw-subnet"
    cidr = "10.0.3.0/24"
  }

  appgw_nsg_rules = []

  create_public_nics = true
  tags = {
    environment = "shared"
    project     = "helloworld"
    managed_by  = "terraform"
  }
}

resource "azurerm_network_interface_security_group_association" "pritunl_nsg" {
  network_interface_id      = module.vnet.public_nic_ids[0]
  network_security_group_id = module.vnet.public_nsg_ids[0]
}

resource "azurerm_network_interface_security_group_association" "jenkins_nsg" {
  network_interface_id      = module.vnet.private_nic_ids[0]
  network_security_group_id = module.vnet.private_nsg_ids[0]
}