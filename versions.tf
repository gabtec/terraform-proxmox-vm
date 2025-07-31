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
