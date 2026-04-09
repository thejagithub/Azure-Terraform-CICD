variable "subscription_id" {
  type    = string
  default = "83c788e7-e715-4617-94ef-5caa0f5d39f4"
}

variable "ssh_public_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCoorGdgB7sDa9n2wNSPkMMLa7Bo+AmAIfCWLHeJ/X/379rBgVXnM6ALeOAkiycnsiQcTvW3jVUjStrX3/TdzXtNsBeal71N2eQF5dkP4vt/JY0vphc69VEhwl4l44V8oxzPPL9HcToDjanQDDeC6dBQ0PmN3rn032ypr0IbJgqVKvcADZm6DTaRRkhPzFGxxRykYR2vrnwXuaSpnI8ko7mkMXsiotDV5IikUnkhj3iDhuvjMs08ozHjQVm0J6NCc/cyRUsSahrR05YC4jxtNUfo2ALX4ZkalmkTwOUtHkRb/VIl525q0zvSKdITs2Ain9B2glfTusA0MIVLcaS+0Au7BDacgka/mTcmhIA+HRZ9xQFqrDsSjBwdcQTt4bvASQs1Oxd3PCOYlcBLeQ+nz2ou8gu6/Jhn8yBrt/I0UeV4CH+V/f+6F1Q94PzLwDKHI2hRst1uBMI8gbKnk4LF477crDZjPMwyi0zqa2oKcI0SFfepGRQiY3d7MnUvWV/Rz8xdSfI1EKLXjO4dypjDPM4XJX5QddsJR8AdLITR+MsvCeqbiBrA1T8qKNHCo7OEmRp5IL5L37mbun7o9ifWaW+o6J5wacIGoHxzOQGWkTIYAMzzAq22Kf2OB1a8waLqEMfTk0D+gHdbZxA5O+tIGF8+JIWsQkF3wGVyLcJ3EF+4w== azuread\thejanagalagama@THEJANA-GALAGAMA"
}

# variable "tags" {
#   type = map(string)
#   default = {
#     environment = "shared"
#     project     = "helloworld"
#     managed_by  = "terraform"
#   }
# }