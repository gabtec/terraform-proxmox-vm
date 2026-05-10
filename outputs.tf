output "vm_ip_addr" {
  value       = proxmox_virtual_environment_vm.ubuntu_vm[*].ipv4_addresses
  description = "The IP address of the new vm"
}

output "vm_mac_addr" {
  value       = proxmox_virtual_environment_vm.ubuntu_vm[*].mac_addresses
  description = "The MAC address of the new vm"
}

output "vm_net_interfaces" {
  value       = proxmox_virtual_environment_vm.ubuntu_vm[*].network_interface_names
  description = "The NIC name of the new vm"
}