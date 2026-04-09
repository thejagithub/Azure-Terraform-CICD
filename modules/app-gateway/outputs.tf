output "app_gateway_id" {
  value = azurerm_application_gateway.agw.id
}

output "backend_pool_id" {
  value = tolist(azurerm_application_gateway.agw.backend_address_pool)[0].id
}

output "public_ip" {
  value = azurerm_public_ip.agw_pip.ip_address
}

output "backend_pool_name" {
  value = "vmss-backend-pool"
}