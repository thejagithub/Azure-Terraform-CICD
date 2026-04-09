output "resource_group_name" {
  value = data.azurerm_resource_group.dev.name
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "vnet_name" {
  value = module.vnet.vnet_name
}

output "app_gateway_public_ip" {
  value = module.app_gateway.public_ip
}

output "vmss_name" {
  value = module.vmss.vmss_name
}

output "vmss_principal_id" {
  value = module.vmss.principal_id
}

output "acr_login_server" {
  value = module.acr.login_server
}

output "acr_admin_username" {
  value = module.acr.admin_username
}

output "acr_admin_password" {
  value     = module.acr.admin_password
  sensitive = true
}