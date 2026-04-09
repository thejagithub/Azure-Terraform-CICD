variable "subscription_id" {
  type    = string
  default = " ## "
}



variable "ssh_public_key" {
  type    = string
  default = " ## "
}



# variable "tags" {
#   type = map(string)
#   default = {
#     environment = "development"
#     project     = "CICD"
#     managed_by  = "terraform"
#   }
# }