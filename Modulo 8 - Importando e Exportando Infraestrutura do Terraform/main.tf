provider "azurerm" {
  features{}
}

resource "azurerm_resource_group" "rg" {
  name = "rg-terraform-import"
  location = "brazilsouth"
  tags = {
    "ambiente" = "treinamento"
  }
}


resource "azurerm_virtual_network" "vnet" {
  name = "vnet-import"
  resource_group_name = "rg-terraform-import"
  location = "brazilsouth"
  address_space = [ "10.0.0.0/16" , "192.168.0.0/16" ]
  tags = {
    "ambiente" = "testes"
  }
}

resource "azurerm_network_security_group" "nsg" {
    location = "brazilsouth"
    name = "nsg-import"
    resource_group_name = "rg-terraform-import"
    tags = {
      "ambiente" = "treinamento"
    }
}

resource "azurerm_network_security_rule" "regras_entrada_liberada" {
  for_each = var.regras_entrada
  resource_group_name = "rg-terraform-import"
  name = "porta_entrada_${each.value}"
  priority = each.key
  direction = "Inbound"
  access = "Allow"
  source_port_range = "*"
  protocol = "Tcp"
  destination_port_range = each.value
  source_address_prefix = "*"
  destination_address_prefix = "*"
  network_security_group_name = "nsg-import"

}
