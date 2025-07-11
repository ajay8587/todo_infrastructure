variable "public_ip_name" {
  description = "Name of the public IP address"
  type        = string
}

variable "location" {
  description = "Location for the public IP address"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group for the public IP address"
  type        = string
}

variable "allocation_method" {
  description = "Allocation method for the public IP address (Static or Dynamic)"
  type        = string

}

variable "sku" {
  description = "SKU for the public IP address (Basic or Standard)"
  type        = string
}