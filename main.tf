resource "azurerm_resource_group" "rg" {
  name     = "rg-${random_pet.random_name.id}"
  location = var.resource_group_location
}

#Module below
resource "random_pet" "random_name" {
  prefix = var.prefix
  length = 2
}

module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"

  resource_group_name = azurerm_resource_group.rg.name
  vnet_location       = var.resource_group_location
  use_for_each        = true
  subnet_names        = var.subnet_names
  subnet_prefixes     = var.subnet_prefixes
}

resource "azurerm_network_interface" "app_nic" {
  name                = "nic-${random_pet.random_name.id}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ip-${random_pet.random_name.id}"
    subnet_id                     = module.vnet.vnet_subnets[0]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "app" {
  name                  = "vm-${random_pet.random_name.id}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.app_nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myosdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  admin_username = random_pet.random_name.id
  admin_password = var.admin_password
}