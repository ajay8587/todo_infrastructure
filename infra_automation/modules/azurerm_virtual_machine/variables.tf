variable "nic_name" {
  description = "Name of the network interface"
  type        = string
}

variable "location" {
  description = "Location for the resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
}




variable "image_publisher" {
  description = "Publisher of the image to use for the virtual machine"
  type        = string
}

variable "image_offer" {
  description = "Offer of the image to use for the virtual machine"
  type        = string
}

variable "image_sku" {
  description = "SKU of the image to use for the virtual machine"
  type        = string
}

variable "image_version" {
  description = "Version of the image to use for the virtual machine"
  type        = string
}
variable "subnet_name" {
  description = "Name of the subnet where the virtual machine will be deployed"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network where the subnet is located"
  type        = string
}

variable "public_ip_name" {
  description = "Name of the public IP address associated with the virtual machine"
  type        = string
}


variable "key_vault_name" {
  description = "The name of the Key Vault where the secrets are stored."
  type        = string
}
variable "secret_username" {
  description = "The name of the secret containing the VM username in the Key Vault."
  type        = string
}

variable "secret_password" {
  description = "The name of the secret containing the VM password in the Key Vault."
  type        = string
}

variable "custom_data_path" {

}