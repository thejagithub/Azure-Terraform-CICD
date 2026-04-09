module "nat_gateway" {
  source = "../../modules/nat-gateway"

  name                = "shared-nat-gateway"
  location            = data.azurerm_resource_group.shared.location
  resource_group_name = data.azurerm_resource_group.shared.name
  subnet_id           = module.vnet.private_subnet_ids[0]
}