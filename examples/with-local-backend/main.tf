module "vm" {
  source = "git@github.com:gabtec/terraform-proxmox-vm.git?ref=v0.1.0"

  # providers specs
  px_addr              = var.px_addr
  px_node              = "pve"
  ssh_private_key_path = "~/.ssh/id_ed25519"
  # vm specs
  vm_name            = var.vm_name
  vm_id              = 100
  vm_template_id     = 7001
  vm_cpus            = 1
  vm_disk_size_in_gb = 8
  vm_mem_in_mb       = 1024
  vm_ip              = "10.10.10.10/24" # "dhcp" OR ip/mask
  vm_gw_ip           = "10.10.10.254"   # only used when vm_ip is not "dhcp"
  vm_vswitch         = "vmbr0"
  vm_storage_pool    = "local-lvm"
  vm_desc_header     = "${title(var.vm_name)} Server"

  vm_tags_list = [var.vm_name, var.created_with] # in use
  vm_desc_props = {
    createdBy   = var.vm_user
    createdFor  = "homelab"
    createdWith = var.created_with
  }
  # secrets
  vm_user                = var.vm_user
  vm_secret              = var.vm_secret
  vm_authorized_ssh_keys = jsonencode(var.vm_auth_keys)
}
