module "acr" {
  source = "../../modules/acr"

  acr_name            = "production26"
  resource_group_name = data.azurerm_resource_group.prod.name
  location            = data.azurerm_resource_group.prod.location
  sku                 = "Basic"
  #tags                = var.tags
}