#####################################################################
##
##      Created 10/9/18 by admin. for Macys
##
#####################################################################

## REFERENCE {"vsphere_network":{"type": "vsphere_reference_network"}}

terraform {
  required_version = "> 0.8.0"
}

provider "vsphere" {
  user           = "${var.user}"
  password       = "${var.password}"
  vsphere_server = "${var.vsphere_server}"

  allow_unverified_ssl = "${var.allow_unverified_ssl}"
  version = "~> 1.2"
}


data "vsphere_virtual_machine" "macys_vm_template" {
  name          = "${var.macys_vm_template_name}"
  datacenter_id = "${data.vsphere_datacenter.macys_vm_datacenter.id}"
}

data "vsphere_datacenter" "macys_vm_datacenter" {
  name = "${var.macys_vm_datacenter_name}"
}

data "vsphere_datastore" "macys_vm_datastore" {
  name          = "${var.macys_vm_datastore_name}"
  datacenter_id = "${data.vsphere_datacenter.macys_vm_datacenter.id}"
}

data "vsphere_network" "network" {
  name          = "${var.network_network_name}"
  datacenter_id = "${data.vsphere_datacenter.macys_vm_datacenter.id}"
}

resource "vsphere_virtual_machine" "macys_vm" {
  name          = "${var.macys_vm_name}"
  datastore_id  = "${data.vsphere_datastore.macys_vm_datastore.id}"
  num_cpus      = "${var.macys_vm_number_of_vcpu}"
  memory        = "${var.macys_vm_memory}"
  guest_id = "${data.vsphere_virtual_machine.macys_vm_template.guest_id}"
  resource_pool_id = "${var.macys_vm_resource_pool}"
  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.macys_vm_template.id}"
  }
  disk {
    name = "${var.macys_vm_disk_name}"
    size = "${var.macys_vm_disk_size}"
  }
}