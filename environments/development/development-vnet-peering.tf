module "vnet-peering" {
  source = "../../modules/vnet-peering"

  vnet_1_name           = module.vnet.vnet_name
  vnet_1_id             = module.vnet.vnet_id
  vnet_1_resource_group = data.azurerm_resource_group.dev.name

  vnet_2_name           = data.terraform_remote_state.shared.outputs.vnet_name
  vnet_2_id             = data.terraform_remote_state.shared.outputs.vnet_id
  vnet_2_resource_group = data.terraform_remote_state.shared.outputs.resource_group_name
}