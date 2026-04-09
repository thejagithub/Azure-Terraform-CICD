output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "appgw_subnet_id" {
  value = azurerm_subnet.appgw.id
}

output "public_subnet_ids" {
  value = azurerm_subnet.public[*].id
}

output "private_subnet_ids" {
  value = azurerm_subnet.private[*].id
}

output "public_subnet_names" {
  value = azurerm_subnet.public[*].name
}

output "private_subnet_names" {
  value = azurerm_subnet.private[*].name
}

output "public_nsg_ids" {
  value = azurerm_network_security_group.public[*].id
}

output "private_nsg_ids" {
  value = azurerm_network_security_group.private[*].id
}

output "public_nic_ids" {
  value = azurerm_network_interface.public[*].id
}

output "private_nic_ids" {
  value = azurerm_network_interface.private[*].id
}

output "public_pip_addresses" {
  value = azurerm_public_ip.public[*].ip_address
}