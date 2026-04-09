module "nat_gateway_az1" {
  source = "../../modules/nat-gateway"

  name                = "Production-Nat-Gateway-az1"
  location            = data.azurerm_resource_group.prod.location
  resource_group_name = data.azurerm_resource_group.prod.name
  subnet_id           = module.vnet.private_subnet_ids[0]
#   tags                = var.tags
}

module "nat_gateway_az2" {
  source = "../../modules/nat-gateway"

  name                = "Production-Nat-Gateway-az2"
  location            = data.azurerm_resource_group.prod.location
  resource_group_name = data.azurerm_resource_group.prod.name
  subnet_id           = module.vnet.private_subnet_ids[1]
#   tags                = var.tags
}