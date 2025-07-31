# --------------------------------------------- #
#   Sensitive Variables (aka secrets)
#   Should be provided from a keyVault
# --------------------------------------------- #
variable "vm_user" { sensitive = true }   # TODO: PROXMOX_VE_SSH_USERNAME
variable "vm_secret" { sensitive = true } # TODO: PROXMOX_VE_SSH_PASSWORD
variable "vm_authorized_ssh_keys" {
  sensitive   = true
  type        = string
  description = "all public ssh keys authorized to access this vm (in a json list(string))"
}
# --------------------------------------------- #
#   Provider Connection Config Variables
# --------------------------------------------- #
variable "px_node" {
  description = "Proxmox Node name"
  type        = string
  default     = "pve"
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

# --------------------------------------------- #
#   VM Config Variables
# --------------------------------------------- #
variable "vm_name" {
  description = "Proxmox VM name"
  type        = string
  default     = "server"
}

variable "vm_desc_header" {
  description = "Proxmox VM descripton (shows up in Notes as a header)"
  type        = string
  # we can use markdown syntax
  default = "Ubuntu Server"
}

variable "vm_desc_props" {
  description = "This will be used to generate the VM Notes for Proxmox Dashboard"
  type = object({
    createdBy   = string
    createdFor  = string
    createdWith = string
  })
  default = {
    createdBy   = "me"
    createdFor  = "homelab"
    createdWith = "terraform"
  }
}

variable "vm_tags_list" {
  type        = list(string)
  default     = ["demo", "terraform"]
  description = "This will appear as tags next to vm id/name, in left menu"
}

variable "vm_id" {
  description = "Proxmox VM id"
  type        = number
  default     = 1000
}

variable "vm_template_id" {
  description = "The template id, to create VM from"
  type        = number
  default     = 9000
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
