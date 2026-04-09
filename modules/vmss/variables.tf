variable "vmss_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "backend_pool_id" {
  type = string
}

variable "acr_login_server" {
  type = string
}

variable "acr_username" {
  type = string
}

variable "acr_password" {
  type      = string
  sensitive = true
}

variable "image_name" {
  type = string
}

variable "container_name" {
  type    = string
  default = "helloworld"
}

variable "os_disk_size_gb" {
  type    = number
}

variable "tags" {
  type    = map(string)
  default = {}
}