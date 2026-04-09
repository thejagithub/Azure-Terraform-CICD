output "vmss_id" {
  value = azurerm_linux_virtual_machine_scale_set.vmss.id
}

output "vmss_name" {
  value = azurerm_linux_virtual_machine_scale_set.vmss.name
}

output "principal_id" {
  value = azurerm_linux_virtual_machine_scale_set.vmss.identity[0].principal_id
}