module "vm" {
  source = "git@github.com:gabtec/terraform-proxmox-vm.git?ref=v0.1.5"

  # providers specs
  px_addr              = var.px_addr
  px_node              = "pve"
  ssh_private_key_path = "~/.ssh/id_ed25519"
  # vm specs
  vm_name      = var.vm_name
  vm_id        = 100
  clone_from   = 7001
  clone_spool  = "local-lvm"
  vm_cpus      = 1
  vm_mem_in_mb = 1024
  vm_ip        = "10.10.10.10/24" # "dhcp" OR ip/mask
  vm_gw_ip     = "10.10.10.254"   # only used when vm_ip is not "dhcp"
  vm_vswitch   = "vmbr0"
  vm_services  = ["Demo Svc"]
  extra_tags   = ["dev"]

  vm_disks = {
    scsi0 = {
      datastore_id = "local-lvm"
      size         = 8
    }
    scsi1 = {
      datastore_id = "local-lvm"
      size         = 16
    }
  }

  # secrets
  vm_user                = var.vm_user
  vm_secret              = var.vm_secret
  vm_authorized_ssh_keys = jsonencode(var.vm_auth_keys)
}
