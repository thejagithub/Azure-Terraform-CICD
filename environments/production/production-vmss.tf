module "vmss" {
  source = "../../modules/vmss"

  vmss_name           = "Production-vmss"
  location            = data.azurerm_resource_group.prod.location
  resource_group_name = data.azurerm_resource_group.prod.name
  vm_size             = "Standard_B1s"
  instance_count      = 1
  admin_username      = "azureuser"
  ssh_public_key      = var.ssh_public_key
  subnet_id           = module.vnet.private_subnet_ids[0]
  backend_pool_id     = module.app_gateway.backend_pool_id
  acr_login_server    = module.acr.login_server
  acr_username        = module.acr.admin_username
  acr_password        = module.acr.admin_password
  image_name          = "html-application"
  container_name      = "CICD"
  os_disk_size_gb     = 30
  #tags                = var.tags
}