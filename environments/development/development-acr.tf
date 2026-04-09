module "acr" {
  source = "../../modules/acr"

  acr_name            = "developmentacr26"
  resource_group_name = data.azurerm_resource_group.dev.name
  location            = data.azurerm_resource_group.dev.location
  sku                 = "Basic"
  #tags                = var.tags
}