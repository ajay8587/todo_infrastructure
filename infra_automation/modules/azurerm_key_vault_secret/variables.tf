variable "key_vault_name" {
  description = "The name of the Key Vault where the secret will be stored."
  type        = string
}


variable "resource_group_name" {
  description = "The name of the resource group where the Key Vault is located."
  type        = string
}

variable "secret_name" {
  description = "The name of the secret to be created in the Key Vault."
  type        = string
}


variable "secret_value" {
  description = "The value of the secret to be stored in the Key Vault."
  type        = string
}