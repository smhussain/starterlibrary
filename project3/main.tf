#####################################################################
##
##      Created 3/20/19 by admin. for project3
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

resource "azurerm_virtual_machine" "windows_5" {
  name                  = "${var.windows_1_name}"
  location              = "${var.vm_location}"
  vm_size               = "${var.vm_size}"
  resource_group_name   = "${azurerm_resource_group.group_1.name}"
  network_interface_ids = ["${azurerm_network_interface.interface_1.id}"]
  tags {
    Name = "${var.windows_1_name}"
  }
  os_profile {
    computer_name  = "${var.windows_1_os_profile_name}"
    admin_username = "${var.windows_1_azure_user}"
    admin_password = "${var.windows_1_azure_user_password}"
  }
  storage_image_reference {
    publisher = "${var.windows_1_publisher}"
    offer     = "${var.windows_1_offer}"
    sku       = "${var.windows_1_sku}"
    version   = "${var.windows_1_version}"
  }
  storage_os_disk {
    name              = "${var.windows_1_os_disk_name}"
    caching           = "${var.windows_1_os_disk_caching}"
    create_option     = "${var.windows_1_os_disk_create_option}"
    managed_disk_type = "${var.windows_1_os_disk_managed_disk_type}"
  }
  delete_os_disk_on_termination = "${var.windows_1_os_disk_delete}"
}

resource "azurerm_virtual_machine" "windows_2" {
  name                  = "${var.windows_2_name}"
  location              = "${var.vm_location}"
  vm_size               = "${var.vm_size}"
  resource_group_name   = "${azurerm_resource_group.group_1.name}"
  network_interface_ids = ["${azurerm_network_interface.interface_2.id}"]
  tags {
    Name = "${var.windows_2_name}"
  }
  os_profile {
    computer_name  = "${var.windows_2_os_profile_name}"
    admin_username = "${var.windows_2_azure_user}"
    admin_password = "${var.windows_2_azure_user_password}"
  }
  storage_image_reference {
    publisher = "${var.windows_2_publisher}"
    offer     = "${var.windows_2_offer}"
    sku       = "${var.windows_2_sku}"
    version   = "${var.windows_2_version}"
  }
  storage_os_disk {
    name              = "${var.windows_2_os_disk_name}"
    caching           = "${var.windows_2_os_disk_caching}"
    create_option     = "${var.windows_2_os_disk_create_option}"
    managed_disk_type = "${var.windows_2_os_disk_managed_disk_type}"
  }
  delete_os_disk_on_termination = "${var.windows_2_os_disk_delete}"
}

resource "azurerm_virtual_machine" "windows" {
  name                  = "${var.windows_name}"
  location              = "${var.vm_location}"
  vm_size               = "${var.vm_size}"
  resource_group_name   = "${azurerm_resource_group.group_2.name}"
  network_interface_ids = ["${azurerm_network_interface.interface.id}"]
  tags {
    Name = "${var.windows_name}"
  }
  os_profile {
    computer_name  = "${var.windows_os_profile_name}"
    admin_username = "${var.windows_azure_user}"
    admin_password = "${var.windows_azure_user_password}"
  }
  storage_image_reference {
    publisher = "${var.windows_publisher}"
    offer     = "${var.windows_offer}"
    sku       = "${var.windows_sku}"
    version   = "${var.windows_version}"
  }
  storage_os_disk {
    name              = "${var.windows_os_disk_name}"
    caching           = "${var.windows_os_disk_caching}"
    create_option     = "${var.windows_os_disk_create_option}"
    managed_disk_type = "${var.windows_os_disk_managed_disk_type}"
  }
  delete_os_disk_on_termination = "${var.windows_os_disk_delete}"
}

resource "azurerm_resource_group" "group_1" {
  name     = "group_1"
  location = "${var.location}"
}

resource "azurerm_resource_group" "group_2" {
  name     = "group_2"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "azure_network" {
  name                = "azure_network"
  address_space       = ["${var.azurerm_network_address_space}"]
  location            = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.group_1.name}"
}

resource "azurerm_network_interface" "interface_1" {
  name                = "${var.network_interface_name}"
  location            = "${var.vm_location}"
  resource_group_name   = "${azurerm_resource_group.group_1.name}"
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
  resource_group_name  = "${azurerm_resource_group.group_1.name}"
}

resource "azurerm_network_interface" "interface_2" {
  name                = "${var.network_interface_name}"
  location            = "${var.vm_location}"
  resource_group_name   = "${azurerm_resource_group.group_1.name}"
  ip_configuration {
    name                          = "ipConfig"
    private_ip_address_allocation = "Static"
    subnet_id  = "${azurerm_subnet.subnet.id}"
  }
}

resource "azurerm_network_interface" "interface" {
  name                = "${var.network_interface_name}"
  location            = "${var.vm_location}"
  resource_group_name   = "${azurerm_resource_group.group_2.name}"
  ip_configuration {
    name                          = "ipConfig"
    private_ip_address_allocation = "Static"
    subnet_id  = "${azurerm_subnet.subnet.id}"
  }
}

