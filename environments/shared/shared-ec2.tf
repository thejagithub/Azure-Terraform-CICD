module "jenkins" {
  source = "../../modules/vm"

  vm_name             = "Shared-Jenkins-vm"
  location            = data.azurerm_resource_group.shared.location
  resource_group_name = data.azurerm_resource_group.shared.name
  vm_size             = "Standard_B2s"
  admin_username      = "azureuser"
  ssh_public_key      = var.ssh_public_key
  subnet_id           = module.vnet.private_subnet_ids[0]
  os_disk_size_gb = 30
  associate_public_ip = false
  user_data           = file("${path.module}/user-data/jenkins-userdata.sh")
}

module "pritunl" {
  source = "../../modules/vm"

  vm_name             = "Shared-Pritunl-vm"
  location            = data.azurerm_resource_group.shared.location
  resource_group_name = data.azurerm_resource_group.shared.name
  vm_size             = "Standard_B2s"
  admin_username      = "azureuser"
  ssh_public_key      = var.ssh_public_key
  subnet_id           = module.vnet.public_subnet_ids[0]
  os_disk_size_gb = 30
  associate_public_ip = true
  user_data           = file("${path.module}/user-data/pritunl-userdata.sh")  
  
}