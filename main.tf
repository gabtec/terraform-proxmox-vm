resource "proxmox_virtual_environment_vm" "ubuntu_vm" {

  name = var.vm_name
  tags = var.vm_tags_list
  # description will show on proxmox vm notes, dashboard
  description = "# ${var.vm_desc_header}\n\n- createdBy: ${var.vm_desc_props.createdBy}\n- createdFor: ${var.vm_desc_props.createdFor}\n- createdWith: ${var.vm_desc_props.createdWith}" # will show on proxmox vm notes
  node_name   = var.px_node
  vm_id       = var.vm_id

  agent {
    # read 'Qemu guest agent' section, change to true only when ready
    enabled = true
  }

  clone {
    full         = true
    vm_id        = var.vm_template_id
    datastore_id = var.vm_storage_pool
  }

  cpu {
    cores   = var.vm_cpus
    sockets = 1
    type    = "host" # default is qemu64 but not recommended
  }

  memory {
    dedicated = var.vm_mem_in_mb # in MiB
    # floating = 1024 # in MiB
    # shared = 1024 # in MiB
  }

  disk {
    datastore_id = var.vm_storage_pool
    interface    = "scsi0"                # scsi | sata | virtio (+ index number)
    size         = var.vm_disk_size_in_gb # disk size in gigabytes (defaults to 8).
    ssd          = true                   # not supported in interface=virtio
  }

  # for Cloud-init
  initialization {
    ip_config {
      ipv4 {
        address = var.vm_ip != "dhcp" ? "${var.vm_ip}" : "dhcp"
        gateway = var.vm_ip == "dhcp" ? null : var.vm_gw_ip # must be omitted when dhcp is used as the address
      }
    }

    dns {
      servers = ["${var.vm_gw_ip}"]
    }

    user_account {
      username = var.vm_user
      password = var.vm_secret
      keys     = jsondecode(var.vm_authorized_ssh_keys)
    }
  }

  network_device {
    bridge = var.vm_vswitch
    # model  = "virtio" #"e1000"
    # mac_address = "optional"
  }

  keyboard_layout = "pt"
  #   machine = "q35"

  on_boot = true # starts with the host
  started = true # Whether to start the virtual machine (defaults to true)

  #  startup {
  #     order      = "3"
  #     up_delay   = "60"
  #     down_delay = "60"
  #   }

  operating_system {
    type = "l26"
  }

  // to use remote provisioner
  connection {
    type        = "ssh"
    user        = var.vm_user
    private_key = file(var.ssh_private_key_path)
    host        = self.ipv4_addresses[1][0]
  }

  provisioner "remote-exec" {
    inline = [
      # add user to sudoers - to prepare for docker provider usage
      "sudo usermod -aG docker $USER",
    ]
  }
}
