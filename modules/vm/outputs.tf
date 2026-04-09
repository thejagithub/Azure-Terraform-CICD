output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.vm.name
}

output "private_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}

output "public_ip" {
  value = var.associate_public_ip ? azurerm_public_ip.vm_pip[0].ip_address : null
}

output "principal_id" {
  value = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}