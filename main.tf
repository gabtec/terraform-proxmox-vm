locals { just_ip = split("/", var.vm_ip)[0] }

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {

  vm_id     = var.vm_id
  name      = var.vm_name
  node_name = var.px_node
  tags      = concat([local.just_ip], var.extra_tags)

  agent {
    # read 'Qemu guest agent' section, change to true only when ready
    enabled = true
  }

  clone {
    full         = true
    vm_id        = var.clone_from
    datastore_id = var.vm_storage_pool
  }

  cpu {
    cores   = var.vm_cpus
    sockets = 1
    type    = "host" # default is qemu64 but not recommended
  }

  memory {
    dedicated = var.vm_mem_in_mb # in MiB
    floating  = var.vm_mem_in_mb # in MiB
    # shared = 1024 # in MiB
  }

  dynamic "disk" {
    for_each = var.vm_disks

    content {
      interface         = disk.key                     # scsi | sata | virtio (+ index number)
      datastore_id      = disk.value.datastore_id      # optional
      path_in_datastore = disk.value.path_in_datastore # optional
      file_format       = disk.value.file_format       # optional: qcow2 | raw | vmdk
      file_id           = disk.value.file_id           # optional: use to import a disk, e.g. "<datastore_id>:<content_type>/<file_name>"
      size              = disk.value.size              # disk size in gigabytes (defaults to 8).
      ssd               = disk.value.ssd               # not supported in interface=virtio
    }
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

  description = <<-EOT
    # ${title(var.vm_name)} Server

    ## Services
    ${join("\n", [for s in var.vm_services : "- ${s}"])}

    ## Tags
    - createdBy: ${var.created_by}
    - createdFor: Homelab
    - createdWith: Terraform
  EOT

}


resource "null_resource" "provision_user_on_docker_group" {
  count = var.add_user_to_docker_group ? 1 : 0

  connection {
    type        = "ssh"
    user        = var.vm_user
    host        = proxmox_virtual_environment_vm.ubuntu_vm.ipv4_addresses[1][0]
    private_key = file(var.ssh_private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      # add user to sudoers - to prepare for docker provider usage
      "sudo usermod -aG docker $USER",
    ]
  }
}