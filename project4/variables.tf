#####################################################################
##
##      Created 4/2/19 by admin. for project4
##
#####################################################################

variable "subscription_id" {
  type = "string"
  description = "Generated"
}

variable "client_id" {
  type = "string"
  description = "Generated"
}

variable "client_secret" {
  type = "string"
  description = "Generated"
}

variable "tenant_id" {
  type = "string"
  description = "Generated"
}

variable "windows2_name" {
  type = "string"
  description = "Generated"
}

variable "vm_location" {
  type = "string"
  description = "Generated"
}

variable "vm_size" {
  type = "string"
  description = "Generated"
}

variable "windows2_os_profile_name" {
  type = "string"
  description = "Specifies the os profile name."
  default = "profilename"
}

variable "windows2_azure_user" {
  type = "string"
  description = "Generated"
}

variable "windows2_azure_user_password" {
  type = "string"
  description = "Generated"
}

variable "windows2_publisher" {
  type = "string"
  default = "MicrosoftWindowsServer"
}

variable "windows2_offer" {
  type = "string"
  default = "WindowsServer"
}

variable "windows2_sku" {
  type = "string"
  default = "Datacenter"
}

variable "windows2_version" {
  type = "string"
  default = "latest"
}

variable "windows2_os_disk_name" {
  type = "string"
  description = "Specifies the disk name."
  default ="osdiskname"
}

variable "windows2_os_disk_caching" {
  type = "string"
  description = "Specifies the caching requirements. (Ex:ReadWrite)"
  default="ReadWrite"
}

variable "windows2_os_disk_create_option" {
  type = "string"
  description = "Specifies how the virtual machine should be created. Possible values are Attach (managed disks only) and FromImage."
}

variable "windows2_os_disk_managed_disk_type" {
  type = "string"
  description = "Specifies the type of managed disk to create. Value must be either Standard_LRS or Premium_LRS. Cannot be used when vhd_uri is specified"
  default = "Standard_LRS"
}

variable "windows2_os_disk_delete" {
  type = "string"
  description = "Delete the OS disk automatically when deleting the VM"
  default = true
}

variable "location" {
  type = "string"
  description = "Generated"
}

variable "windows21_name" {
  type = "string"
  description = "Generated"
}

variable "windows21_os_profile_name" {
  type = "string"
  description = "Specifies the os profile name."
  default = "profilename"
}

variable "windows21_azure_user" {
  type = "string"
  description = "Generated"
}

variable "windows21_azure_user_password" {
  type = "string"
  description = "Generated"
}

variable "windows21_publisher" {
  type = "string"
  default = "MicrosoftWindowsServer"
}

variable "windows21_offer" {
  type = "string"
  default = "WindowsServer"
}

variable "windows21_sku" {
  type = "string"
  default = "Datacenter"
}

variable "windows21_version" {
  type = "string"
  default = "latest"
}

variable "windows21_os_disk_name" {
  type = "string"
  description = "Specifies the disk name."
  default ="osdiskname"
}

variable "windows21_os_disk_caching" {
  type = "string"
  description = "Specifies the caching requirements. (Ex:ReadWrite)"
  default="ReadWrite"
}

variable "windows21_os_disk_create_option" {
  type = "string"
  description = "Specifies how the virtual machine should be created. Possible values are Attach (managed disks only) and FromImage."
}

variable "windows21_os_disk_managed_disk_type" {
  type = "string"
  description = "Specifies the type of managed disk to create. Value must be either Standard_LRS or Premium_LRS. Cannot be used when vhd_uri is specified"
  default = "Standard_LRS"
}

variable "windows21_os_disk_delete" {
  type = "string"
  description = "Delete the OS disk automatically when deleting the VM"
  default = true
}

variable "azurerm_network_address_space" {
  type = "string"
  description = "Generated"
}

variable "network_interface_name" {
  type = "string"
  description = "Network Interface Name"
}

variable "address_prefix" {
  type = "string"
  description = "Generated"
}

