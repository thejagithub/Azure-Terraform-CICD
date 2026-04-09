output "resource_group_name" {
  value = data.azurerm_resource_group.shared.name
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "vnet_name" {
  value = module.vnet.vnet_name
}

output "public_subnet_ids" {
  value = module.vnet.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vnet.private_subnet_ids
}

output "jenkins_private_ip" {
  value = module.jenkins.private_ip
}

output "jenkins_principal_id" {
  value = module.jenkins.principal_id
}

output "pritunl_public_ip" {
  value = module.pritunl.public_ip
}