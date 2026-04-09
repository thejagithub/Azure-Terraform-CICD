resource "azurerm_virtual_network_peering" "peering_1" {
  name                      = "${var.vnet_1_name}-to-${var.vnet_2_name}"
  resource_group_name       = var.vnet_1_resource_group
  virtual_network_name      = var.vnet_1_name
  remote_virtual_network_id = var.vnet_2_id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "peering_2" {
  name                      = "${var.vnet_2_name}-to-${var.vnet_1_name}"
  resource_group_name       = var.vnet_2_resource_group
  virtual_network_name      = var.vnet_2_name
  remote_virtual_network_id = var.vnet_1_id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}