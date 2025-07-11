variable "sql_server_name" {
  description = "Name of the SQL server"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location for the resources"
  type        = string
}
variable "key_vault_name" {
  description = "Name of the Key Vault where secrets are stored"
  type        = string
}
variable "sql_server_username" {
  description = "Name of the SQL server username secret in Key Vault"
  type        = string
}
variable "sql_sever_password" {
  description = "Name of the SQL server password secret in Key Vault"
  type        = string
}
