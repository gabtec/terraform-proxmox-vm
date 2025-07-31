output "vm_ip_addr" {
  value = proxmox_virtual_environment_vm.ubuntu_vm[*].ipv4_addresses
}

output "vm_mac_addr" {
  value = proxmox_virtual_environment_vm.ubuntu_vm[*].mac_addresses
}

output "vm_net_interfaces" {
  value = proxmox_virtual_environment_vm.ubuntu_vm[*].network_interface_names
}