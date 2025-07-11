
resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"

  administrator_login          = "missadministrator"
  administrator_login_password = "thisIsKat11"
 
  

}


data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}


data "azurerm_key_vault_secret" "sql_username" {
  name         = var.sql_server_username
  key_vault_id = data.azurerm_key_vault.kv.id
}


data "azurerm_key_vault_secret" "sql_password" {
  name         = var.sql_sever_password
  key_vault_id = data.azurerm_key_vault.kv.id
}
