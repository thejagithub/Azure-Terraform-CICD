module "app_gateway" {
  source = "../../modules/app-gateway"

  name                = "Development-App-Gateway"
  location            = data.azurerm_resource_group.dev.location
  resource_group_name = data.azurerm_resource_group.dev.name
  subnet_id           = module.vnet.appgw_subnet_id
  #tags                = var.tags

  depends_on = [module.vnet]
}