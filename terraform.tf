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
  }
}

provider "azurerm" {
  features {}
}

provider "hcp" {}

provider "datadog" {}

provider "environment" {}