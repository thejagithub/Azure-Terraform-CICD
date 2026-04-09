data "terraform_remote_state" "shared" {
  backend = "azurerm"
  config = {
    resource_group_name  = "Task9-Thejana-Shared-RG"
    storage_account_name = "task9sharedstate"
    container_name       = "tfstate"
    key                  = "shared.terraform.tfstate"
  }
}