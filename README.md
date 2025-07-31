# Terraform Proxmox VM Module

This is a custom, opinionated, proxmox module to create a vm

## Pre-Requisites

- it makes use of bpg/proxmox provider
- the vm will be created by cloning a template VM, that MUST exist, and
- should have qemu-guest-agent and docker installed [see my other repo](https://github.com/gabtec/proxmox-template-builder)
- you should already have generated a ssh key-pair

## Usage

```hcl
module "vm" {
  source = "git@github.com:gabtec/terraform-proxmox-vm.git?ref=v0.1.0"
  # ...
}
```
