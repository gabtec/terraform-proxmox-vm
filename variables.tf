# --------------------------------------------- #
#   Opinionated defaults
# --------------------------------------------- #
variable "px_node" {
  default     = "pve"
  description = "The Proxmox node id"
}

variable "px_addr" {
  description = "Proxmox Server Address (ip:port or fqdn)"
  type        = string
  default     = "https://127.0.0.1:8006" # no slash at the end

  validation {
    condition     = can(regex("^http[s]?://", var.px_addr)) && can(regex("^.+[^/]$", var.px_addr))
    error_message = "The URL must start with 'http' or 'https' and must not end with a slash (/)."
  }
}

variable "clone_from" {
  description = "The VM Template ID to clone"
  default     = 9024
  type        = number
}

variable "extra_tags" {
  default     = []
  description = "Extra tags to add to the vm. By default the IP is added"
}

variable "vm_services" {
  description = "A list of services running in the VM. Will be listed in the notes markdown"
  default     = []
}

# --------------------------------------------- #
#   Sensitive Variables (aka secrets)
#   Should be provided from a keyVault
# --------------------------------------------- #
variable "vm_user" {
  # TODO: PROXMOX_VE_SSH_USERNAME
  description = "The username to login into the vm"
  sensitive   = true
}
variable "vm_secret" {
  # TODO: PROXMOX_VE_SSH_PASSWORD
  description = "The user password to login into the vm"
  sensitive   = true
}

variable "vm_authorized_ssh_keys" {
  sensitive   = true
  type        = string
  description = "All public ssh keys authorized to access this vm (in a json list(string))"
}

# --------------------------------------------- #
#   VM Config Variables
# --------------------------------------------- #
variable "vm_name" {
  description = "Proxmox VM name"
  type        = string
  default     = "server"
}

variable "created_by" {
  description = "The name of the maintainer of this configs"
  default = "me"
}

variable "vm_id" {
  description = "Proxmox VM id"
  type        = number
  default     = 1000
}

variable "vm_storage_pool" {
  description = "The storage pool name, where to place vm disk"
  type        = string
  default     = "local-lvm"
}

variable "vm_cpus" {
  description = "Proxmox VM number of CPUs"
  type        = number
  default     = 1
}

variable "vm_mem_in_mb" {
  description = "Proxmox VM MiB of memory"
  type        = number
  default     = 512
}

variable "vm_disk_size_in_gb" {
  description = "Proxmox VM disk size in GiB"
  type        = number
  default     = 8
}

variable "vm_ip" {
  type        = string
  default     = "dhcp"
  description = "Proxmox VM IP. Can be 'dhcp' keyword or IP that MUST include /netmask"
  # example = "192.168.1.2/24" OR "dhcp"
  validation {
    condition = (
      var.vm_ip == "dhcp" ||
      can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.vm_ip))
    )
    error_message = "Value must be either 'dhcp' or a valid CIDR notation (e.g., '192.168.1.0/24')."
  }
}

variable "vm_gw_ip" {
  default     = "192.168.10.254"
  description = "Network Gateway IP"
  type        = string
}

variable "vm_vswitch" {
  description = "Proxmox virtual switch to connect VM to"
  type        = string
  default     = "vmbr0"
}

variable "ssh_private_key_path" {
  description = "SSH private key path"
  type        = string
  default     = "~/.ssh/id_ed25519"
  # TODO: PROXMOX_VE_SSH_PRIVATE_KEY
}

variable "add_user_to_docker_group" {
  type    = bool
  default = false
  description = "If you use a base image already with docker installed, you can choose to add user to docker group"
}