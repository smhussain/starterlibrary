#####################################################################
##
##      Created 10/9/18 by admin. for Macys
##
#####################################################################

variable "user" {
  type = "string"
  description = "Generated"
}

variable "password" {
  type = "string"
  description = "Generated"
}

variable "vsphere_server" {
  type = "string"
  description = "Generated"
}

variable "allow_unverified_ssl" {
  type = "string"
  description = "Generated"
}

variable "macys_vm_name" {
  type = "string"
  description = "Virtual machine name for macys_vm"
}

variable "macys_vm_number_of_vcpu" {
  type = "string"
  description = "Number of virtual cpu's."
}

variable "macys_vm_memory" {
  type = "string"
  description = "Memory allocation."
}

variable "macys_vm_disk_name" {
  type = "string"
  description = "The name of the disk. Forces a new disk if changed. This should only be a longer path if attaching an external disk."
}

variable "macys_vm_disk_size" {
  type = "string"
  description = "The size of the disk, in GiB."
}

variable "macys_vm_template_name" {
  type = "string"
  description = "Generated"
}

variable "macys_vm_datacenter_name" {
  type = "string"
  description = "Generated"
}

variable "macys_vm_datastore_name" {
  type = "string"
  description = "Generated"
}

variable "macys_vm_resource_pool" {
  type = "string"
  description = "Resource pool."
}

variable "network_network_name" {
  type = "string"
  description = "Generated"
}

