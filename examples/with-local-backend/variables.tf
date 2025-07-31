variable "px_addr" {}
variable "px_user" {}
variable "px_secret" {}
variable "created_with" { default = "terraform" }
variable "vm_name" {}
variable "vm_user" {}
variable "vm_secret" {}
variable "vm_auth_keys" { type = list(string) }
