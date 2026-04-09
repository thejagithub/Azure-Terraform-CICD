data "terraform_remote_state" "shared" {
  backend = "azurerm"
  config = {
    resource_group_name  = "shared-RG"
    storage_account_name = "sharedstate"
    container_name       = "tfstate"
    key                  = "shared.terraform.tfstate"
  }
}