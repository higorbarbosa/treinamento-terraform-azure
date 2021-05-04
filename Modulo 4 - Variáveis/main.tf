provider "azurerm" {
    features {
    }
}

resource "azurerm_resource_group" "grupo-recurso" {
    name = var.namerg
    location = var.location
    tags = merge(var.tags, {treinamento = "terraform"}) 
  
}

resource "azurerm_virtual_network" "vnet" {
  name = "vnet-terraform-treinamento"
  resource_group_name = "${azurerm_resource_group.grupo-recurso.name}"
  location = var.location
  address_space = var.vnetenderecos
}
