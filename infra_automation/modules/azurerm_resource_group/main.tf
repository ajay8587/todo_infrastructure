resource "azurerm_resource_group" "Resource_Group" {

  name     = var.resource_group_name
  location = var.resource_group_location
}
