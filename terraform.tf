terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.102.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }

    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.88.0"
    }

    datadog = {
      source  = "DataDog/datadog"
      version = "~> 3.39.0"
    }

    environment = {
      source  = "MorganPeat/environment"
      version = "0.2.6"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "0.55.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "3.25.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "hcp" {}

# provider "datadog" {}

provider "environment" {}

provider "tfe" {
  hostname = var.tf_hostname
}

provider "vault" {
  address   = data.tfe_outputs.aiops_platform_vault.nonsensitive_values.vault_cluster_adress
  token     = data.tfe_outputs.aiops_platform_vault.values.vault_admin_token
  namespace = data.tfe_outputs.aiops_platform_vault.nonsensitive_values.vault_cluster_namespace
}