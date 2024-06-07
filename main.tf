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
  subnet_service_endpoints = {
    (var.subnet_names[0]) = ["Microsoft.CognitiveServices"]
  }
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

  identity {
    type = "SystemAssigned"
  }

  network_interface_ids = [azurerm_network_interface.app_nic.id]

  source_image_id = data.hcp_packer_artifact.ubuntu_ai_image.external_identifier

  os_disk {
    name                 = "myosdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_username = random_pet.random_name.id

  admin_ssh_key {
    public_key = var.azure_pkey
    username   = random_pet.random_name.id
  }

  disable_password_authentication = true
}

resource "datadog_integration_azure" "landing_zone_DD_monitoring" {
  tenant_name   = data.environment_variable.azure_tenant_id.value
  client_id     = data.environment_variable.azure_client_id.value
  client_secret = data.environment_sensitive_variable.azure_client_secret.value
}

module "openai" {
  depends_on = [
    module.vnet
    // As the vnet is referenced *in* the private_endpoint object
    // it is not explicitely understood as a pre-requisite by terraform
    // hence adding the explicit dependency here
  ]

  source  = "Azure/openai/azurerm"
  version = "0.1.3"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  private_endpoint = {
    "pe_endpoint" = {
      vnet_rg_name = azurerm_resource_group.rg.name
      vnet_name    = module.vnet.vnet_name
      subnet_name  = var.subnet_names[0]

      private_dns_entry_enabled = true

      name = "pe_one"
    }
  }

  deployment = {
    "gpt-4" = {
      name          = var.openai_deployment_model_name
      model_format  = var.openai_deployment_model_fmt
      model_name    = var.openai_deployment_model_name
      model_version = var.openai_deployment_model_version
      scale_type    = var.openai_deployment_scale_type
    }

  }
}