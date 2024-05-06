resource "random_pet" "random_name" {
  prefix = var.prefix
  length = 2
}

resource "azurerm_resource_group" "rg" {
  name = "rg-${random_pet.random_name.id}"
  location = var.resource_group_location
}

module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"

  resource_group_name = azurerm_resource_group.rg.name
  vnet_location = var.resource_group_location
  use_for_each = true
  subnet_names = var.subnet_names
  subnet_prefixes = var.subnet_prefixes
}
