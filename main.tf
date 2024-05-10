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

data "hcp_packer_artifact" "ubuntu_ai_image" {
  bucket_name  = var.pkr_bucket_name
  channel_name = var.pkr_channel_name
  platform     = var.pkr_platform
  region       = var.pkr_region
}


resource "azurerm_linux_virtual_machine" "app" {
  name                = "vm-${random_pet.random_name.id}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_DS1_v2"

  network_interface_ids = [azurerm_network_interface.app_nic.id]

  source_image_id = data.hcp_packer_artifact.ubuntu_ai_image.external_identifier

  os_disk {
    name                 = "myosdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_username = random_pet.random_name.id
  admin_password = var.admin_password

  disable_password_authentication = false #to be removed when switching to SSH cert
}

resource "datadog_integration_azure" "sandbox" {
  tenant_name   = var.ARM_TENANT_ID
  client_id     = var.ARM_CLIENT_ID
  client_secret = var.ARM_CLIENT_SECRET
}