resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = data.azurerm_subnet.subnet_data.id
  network_security_group_id = data.azurerm_network_security_group.nsg_data.id

}


data "azurerm_subnet" "subnet_data" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name

}

data "azurerm_network_security_group" "nsg_data" {
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
}