# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.88.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
  subscription_id = "aeb169ae-7f30-4c18-b471-10b5e06576ed"
  client_id = "01d93c39-6f24-4b77-9e7a-05f0d460d686"
  client_secret = "jYG8Q~tMpphEnbSI5UrWnXIsAjERQlVf.ucCjdpU"
  tenant_id = "28336afb-cc13-4e5d-800f-0ddf83ddfa97"  
}

resource "azurerm_resource_group" "rg1" { # rg1 is not the resource group name it is just the block of code name
  name     = "Terraform_RSG"
  location = "Central India"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "Terraform_vnet"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.10.1.0/24"]
}