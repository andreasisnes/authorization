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
  name     = "rg-authorization-${local.environment}-${var.instance}"
  location = local.location
}

resource "azurerm_log_analytics_workspace" "log" {
  name                = "log-authorization-${var.environment}-${var.instance}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
