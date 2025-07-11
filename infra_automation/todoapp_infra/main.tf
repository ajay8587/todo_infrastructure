module "resource_group" {
  source                  = "../modules/azurerm_resource_group"
  resource_group_name     = "rg-todoapp"
  resource_group_location = "Central India"
}


module "virtual_network" {
  source                   = "../modules/azurerm_virtual_network"
  depends_on               = [module.resource_group]
  virtual_network_name     = "vnet-todoapp"
  virtual_network_location = "Central India"
  resource_group_name      = "rg-todoapp"
  address_space            = ["10.0.0.0/16"]
}



module "frontend_subnet" {
  source               = "../modules/azurerm_subnet"
  depends_on           = [module.virtual_network]
  subnet_name          = "frontend_subnet"
  resource_group_name  = "rg-todoapp"
  virtual_network_name = "vnet-todoapp"
  address_prefixes     = ["10.0.0.0/24"]
}
module "backend_subnet" {
  source               = "../modules/azurerm_subnet"
  depends_on           = [module.virtual_network]
  subnet_name          = "backend_subnet"
  resource_group_name  = "rg-todoapp"
  virtual_network_name = "vnet-todoapp"
  address_prefixes     = ["10.0.2.0/24"]
}



module "frontend_vm" {
  source     = "../modules/azurerm_virtual_machine"
  depends_on = [module.frontend_subnet, module.public_ip_frontend, module.key_vault]

  nic_name            = "nic-frontend"
  location            = "Central India"
  resource_group_name = "rg-todoapp"
  vm_name             = "vm-frontend"
  vm_size             = "Standard_B1s"

  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-focal"
  image_sku            = "20_04-LTS"
  image_version        = "latest"
  subnet_name          = "frontend_subnet"
  virtual_network_name = "vnet-todoapp"
  public_ip_name       = "pip-frontend"
  key_vault_name       = "kv-todoapp-ajay"
  secret_username      = "fe-vm-username"
  secret_password      = "fe-vm-password"
  custom_data_path     = "../scripts/nginx.sh"




}


module "backend_vm" {
  source     = "../modules/azurerm_virtual_machine"
  depends_on = [module.backend_subnet, module.public_ip_backend, module.key_vault]

  nic_name            = "nic-backend"
  location            = "Central India"
  resource_group_name = "rg-todoapp"
  vm_name             = "vm-backend"
  vm_size             = "Standard_B1s"

  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-focal"
  image_sku            = "20_04-LTS"
  image_version        = "latest"
  subnet_name          = "backend_subnet"
  virtual_network_name = "vnet-todoapp"
  public_ip_name       = "pip-backend"
  key_vault_name       = "kv-todoapp-ajay"
  secret_username      = "be-vm-username"
  secret_password      = "be-vm-password"
  custom_data_path     = "../scripts/python.sh"

}



module "public_ip_frontend" {
  source              = "../modules/azurerm_public_ip"
  depends_on          = [module.resource_group]
  public_ip_name      = "pip-frontend"
  location            = "Central India"
  resource_group_name = "rg-todoapp"
  allocation_method   = "Static"
  sku                 = "Standard"
}


module "public_ip_backend" {
  source              = "../modules/azurerm_public_ip"
  depends_on          = [module.resource_group]
  public_ip_name      = "pip-backend"
  location            = "Central India"
  resource_group_name = "rg-todoapp"
  allocation_method   = "Static"
  sku                 = "Standard"
}


module "sql_server" {
  depends_on          = [module.resource_group, module.sql_server_password]
  source              = "../modules/azurerm_sql_server"
  sql_server_name     = "sqlserver-todoapp"
  resource_group_name = "rg-todoapp"
  location            = "Central India"
  key_vault_name      = "kv-todoapp-ajay"
  sql_server_username = "sql-server-username"
  sql_sever_password  = "sql-server-password"
}

module "sql_database" {
  depends_on          = [module.sql_server]
  source              = "../modules/azurerm_sql_database"
  sql_server_name     = "sqlserver-todoapp"
  resource_group_name = "rg-todoapp"
  sql_database_name   = "todoappdb"

}


module "key_vault" {
  depends_on          = [module.resource_group]
  source              = "../modules/azurerm_key_vault"
  key_vault_name      = "kv-todoapp-ajay"
  resource_group_name = "rg-todoapp"
  location            = "Central India"

}



module "fe_vm_username" {
  depends_on          = [module.key_vault]
  source              = "../modules/azurerm_key_vault_secret"
  key_vault_name      = "kv-todoapp-ajay"
  resource_group_name = "rg-todoapp"
  secret_name         = "fe-vm-username"
  secret_value        = "feadmin"
}


module "fe_vm_password" {
  depends_on          = [module.key_vault]
  source              = "../modules/azurerm_key_vault_secret"
  key_vault_name      = "kv-todoapp-ajay"
  resource_group_name = "rg-todoapp"
  secret_name         = "fe-vm-password"
  secret_value        = "Password@1234"
}


module "be_vm_username" {
  depends_on          = [module.key_vault]
  source              = "../modules/azurerm_key_vault_secret"
  key_vault_name      = "kv-todoapp-ajay"
  resource_group_name = "rg-todoapp"
  secret_name         = "be-vm-username"
  secret_value        = "beadmin"
}

module "be_vm_password" {
  depends_on          = [module.key_vault]
  source              = "../modules/azurerm_key_vault_secret"
  key_vault_name      = "kv-todoapp-ajay"
  resource_group_name = "rg-todoapp"
  secret_name         = "be-vm-password"
  secret_value        = "Password@1234"
}

module "sql_server_username" {
  depends_on          = [module.key_vault]
  source              = "../modules/azurerm_key_vault_secret"
  key_vault_name      = "kv-todoapp-ajay"
  resource_group_name = "rg-todoapp"
  secret_name         = "sql-server-username"
  secret_value        = "sqladmin"
}

module "sql_server_password" {
  depends_on          = [module.key_vault]
  source              = "../modules/azurerm_key_vault_secret"
  key_vault_name      = "kv-todoapp-ajay"
  resource_group_name = "rg-todoapp"
  secret_name         = "sql-server-password"
  secret_value        = "Password@1234"
}


module "fensg" {
  source              = "../modules/azurerm_network_security_group"
  depends_on          = [module.resource_group, module.frontend_vm]
  nsg_name            = "fe_nsg"
  resource_group_name = "rg-todoapp"
  location            = "central India"
}

module "bensg" {
  source              = "../modules/azurerm_network_security_group"
  depends_on          = [module.resource_group, module.backend_vm]
  nsg_name            = "be_nsg"
  resource_group_name = "rg-todoapp"
  location            = "central India"
}

module "nsg_asociation_frontend" {
  depends_on = [module.fensg, module.frontend_vm]

  source               = "../modules/azurerm_subnet_nsg_association"
  subnet_name          = "frontend_subnet"
  virtual_network_name = "vnet-todoapp"
  resource_group_name  = "rg-todoapp"
  nsg_name             = "fe_nsg"

}

module "nsg_asociation_backend" {
  depends_on = [module.bensg, module.backend_vm]

  source               = "../modules/azurerm_subnet_nsg_association"
  subnet_name          = "backend_subnet"
  virtual_network_name = "vnet-todoapp"
  resource_group_name  = "rg-todoapp"
  nsg_name             = "be_nsg"

}

