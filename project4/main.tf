#####################################################################
##
##      Created 4/2/19 by admin. for project4
##
#####################################################################

terraform {
  required_version = "> 0.8.0"
}

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
  version = "~> 1.1"
}


resource "azurerm_virtual_machine" "windows2" {
  name                  = "${var.windows2_name}"
  location              = "${var.vm_location}"
  vm_size               = "${var.vm_size}"
  resource_group_name   = "${azurerm_resource_group.RG1.name}"
  network_interface_ids = ["${azurerm_network_interface.interface1.id}"]
  tags {
    Name = "${var.windows2_name}"
  }
  os_profile {
    computer_name  = "${var.windows2_os_profile_name}"
    admin_username = "${var.windows2_azure_user}"
    admin_password = "${var.windows2_azure_user_password}"
  }
  storage_image_reference {
    publisher = "${var.windows2_publisher}"
    offer     = "${var.windows2_offer}"
    sku       = "${var.windows2_sku}"
    version   = "${var.windows2_version}"
  }
  storage_os_disk {
    name              = "${var.windows2_os_disk_name}"
    caching           = "${var.windows2_os_disk_caching}"
    create_option     = "${var.windows2_os_disk_create_option}"
    managed_disk_type = "${var.windows2_os_disk_managed_disk_type}"
  }
  delete_os_disk_on_termination = "${var.windows2_os_disk_delete}"
}

resource "azurerm_virtual_machine" "windows21" {
  name                  = "${var.windows21_name}"
  location              = "${var.vm_location}"
  vm_size               = "${var.vm_size}"
  resource_group_name   = "${azurerm_resource_group.RG1.name}"
  network_interface_ids = ["${azurerm_network_interface.interface2.id}"]
  tags {
    Name = "${var.windows21_name}"
  }
  os_profile {
    computer_name  = "${var.windows21_os_profile_name}"
    admin_username = "${var.windows21_azure_user}"
    admin_password = "${var.windows21_azure_user_password}"
  }
  storage_image_reference {
    publisher = "${var.windows21_publisher}"
    offer     = "${var.windows21_offer}"
    sku       = "${var.windows21_sku}"
    version   = "${var.windows21_version}"
  }
  storage_os_disk {
    name              = "${var.windows21_os_disk_name}"
    caching           = "${var.windows21_os_disk_caching}"
    create_option     = "${var.windows21_os_disk_create_option}"
    managed_disk_type = "${var.windows21_os_disk_managed_disk_type}"
  }
  delete_os_disk_on_termination = "${var.windows21_os_disk_delete}"
}

resource "azurerm_resource_group" "RG1" {
  name     = "RG1"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "azure_network" {
  name                = "azure_network"
  address_space       = ["${var.azurerm_network_address_space}"]
  location            = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.RG1.name}"
}

resource "azurerm_network_interface" "interface1" {
  name                = "${var.network_interface_name}"
  location            = "${var.vm_location}"
  resource_group_name   = "${azurerm_resource_group.RG1.name}"
  ip_configuration {
    name                          = "ipConfig"
    private_ip_address_allocation = "Static"
    subnet_id  = "${azurerm_subnet.subnet.id}"
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  virtual_network_name = "${azurerm_virtual_network.azure_network.name}"
  address_prefix       = "${var.address_prefix}"
  resource_group_name  = "${azurerm_resource_group.RG1.name}"
}

resource "azurerm_network_interface" "interface2" {
  name                = "${var.network_interface_name}"
  location            = "${var.vm_location}"
  resource_group_name   = "${azurerm_resource_group.RG1.name}"
  ip_configuration {
    name                          = "ipConfig"
    private_ip_address_allocation = "Static"
    subnet_id  = "${azurerm_subnet.subnet.id}"
  }
}