terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.100.0"
    }
  }

  backend "azurerm" {
    use_azuread_auth = true
  }
}

provider "azurerm" {
  use_oidc = true
  features {}
}

locals {
  location    = "norwayeast"
  environment = lower(var.environment)
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-authorization-${lower(local.environment)}-${var.instance}"
  location = local.location
}
