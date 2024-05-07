resource "azurerm_public_ip" "app_public_ip" {
  count               = var.is_public ? 1 : 0
  name                = "network-ip-${random_pet.random_name.id}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "app_sg" {
  name                = "network-sg-${random_pet.random_name.id}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name = "TCP"
    protocol = "Tcp"
    direction = "Inbound"
    source_address_prefix      = "*"
    source_port_range = "*"
    destination_address_prefix = "*"
    destination_port_range = "5000"
    access = "Allow"
    
    priority = 1002
  } 

}

resource "azurerm_network_interface" "app_nic" {
  name                = "nic-${random_pet.random_name.id}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ip-${random_pet.random_name.id}"
    subnet_id                     = module.vnet.vnet_subnets[0]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.is_public ? azurerm_public_ip.app_public_ip[0].id : null

  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.app_nic.id
  network_security_group_id = azurerm_network_security_group.app_sg.id
}