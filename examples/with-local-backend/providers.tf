terraform {
  # min terraform version
  required_version = ">= 1.12.0"

  # other providers
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.80.0"
    }
  }
}

provider "proxmox" {
  endpoint = "${var.px_addr}/api2/json"
  # e.g. 'USER@REALM!TOKENID=UUID'
  api_token = var.px_secret

  insecure = true # when using self-signed certificates

  # uncomment (unless on Windows...)
  # tmp_dir  = "/var/tmp"

  # required to execute commands on the node to perform actions that are not supported by Proxmox API
  # e.g. safer if using provisioner "remote-exec" {}
  ssh {
    agent = true
    # TODO: uncomment and configure if using api_token instead of password
    # When using API Token a username is required here, or env PROXMOX_VE_USERNAME or PROXMOX_VE_SSH_USERNAME
    username = "terraform"
  }
}
