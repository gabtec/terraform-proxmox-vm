## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >=0.104.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | >=0.104.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [null_resource.provision_user_on_docker_group](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [proxmox_virtual_environment_vm.ubuntu_vm](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_add_user_to_docker_group"></a> [add\_user\_to\_docker\_group](#input\_add\_user\_to\_docker\_group) | If you use a base image already with docker installed, you can choose to add user to docker group | `bool` | `false` | no |
| <a name="input_clone_from"></a> [clone\_from](#input\_clone\_from) | The template id, to create VM from | `number` | `9000` | no |
| <a name="input_created_by"></a> [created\_by](#input\_created\_by) | The name of the maintainer of this configs | `string` | `"me"` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add to the vm. By default the IP is added | `list` | `[]` | no |
| <a name="input_px_addr"></a> [px\_addr](#input\_px\_addr) | Proxmox Server Address (ip:port or fqdn) | `string` | `"https://127.0.0.1:8006"` | no |
| <a name="input_px_node"></a> [px\_node](#input\_px\_node) | The Proxmox node id | `string` | `"pve"` | no |
| <a name="input_ssh_private_key_path"></a> [ssh\_private\_key\_path](#input\_ssh\_private\_key\_path) | SSH private key path | `string` | `"~/.ssh/id_ed25519"` | no |
| <a name="input_vm_authorized_ssh_keys"></a> [vm\_authorized\_ssh\_keys](#input\_vm\_authorized\_ssh\_keys) | All public ssh keys authorized to access this vm (in a json list(string)) | `string` | n/a | yes |
| <a name="input_vm_cpus"></a> [vm\_cpus](#input\_vm\_cpus) | Proxmox VM number of CPUs | `number` | `1` | no |
| <a name="input_vm_disk_size_in_gb"></a> [vm\_disk\_size\_in\_gb](#input\_vm\_disk\_size\_in\_gb) | Proxmox VM disk size in GiB | `number` | `8` | no |
| <a name="input_vm_gw_ip"></a> [vm\_gw\_ip](#input\_vm\_gw\_ip) | Network Gateway IP | `string` | `"192.168.10.254"` | no |
| <a name="input_vm_id"></a> [vm\_id](#input\_vm\_id) | Proxmox VM id | `number` | `1000` | no |
| <a name="input_vm_ip"></a> [vm\_ip](#input\_vm\_ip) | Proxmox VM IP. Can be 'dhcp' keyword or IP that MUST include /netmask | `string` | `"dhcp"` | no |
| <a name="input_vm_mem_in_mb"></a> [vm\_mem\_in\_mb](#input\_vm\_mem\_in\_mb) | Proxmox VM MiB of memory | `number` | `512` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Proxmox VM name | `string` | `"server"` | no |
| <a name="input_vm_secret"></a> [vm\_secret](#input\_vm\_secret) | The user password to login into the vm | `any` | n/a | yes |
| <a name="input_vm_services"></a> [vm\_services](#input\_vm\_services) | A list of services running in the VM. Will be listed in the notes markdown | `list` | `[]` | no |
| <a name="input_vm_storage_pool"></a> [vm\_storage\_pool](#input\_vm\_storage\_pool) | The storage pool name, where to place vm disk | `string` | `"local-lvm"` | no |
| <a name="input_vm_user"></a> [vm\_user](#input\_vm\_user) | The username to login into the vm | `any` | n/a | yes |
| <a name="input_vm_vswitch"></a> [vm\_vswitch](#input\_vm\_vswitch) | Proxmox virtual switch to connect VM to | `string` | `"vmbr0"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_vm_ip_addr"></a> [vm\_ip\_addr](#output\_vm\_ip\_addr) | The IP address of the new vm |
| <a name="output_vm_mac_addr"></a> [vm\_mac\_addr](#output\_vm\_mac\_addr) | The MAC address of the new vm |
| <a name="output_vm_net_interfaces"></a> [vm\_net\_interfaces](#output\_vm\_net\_interfaces) | The NIC name of the new vm |
