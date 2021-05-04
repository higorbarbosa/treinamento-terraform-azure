resource "azurerm_resource_group" "vnetrg" {
  location = "brazilsouth"
  name = "vnetrg"
}

resource "azurerm_network_security_group" "nsg" {
  name = "treinamento-nsg"
  location = "brazilsouth"
  resource_group_name = "vnetrg"
  depends_on = [ 
      azurerm_resource_group.vnetrg
   ]
}

variable "regras_entrada" {
  type = map
  description = "Lista de Portas de Entrada liberadas no NSG"
  default =  {
      101 = 80
      102 = 443
      103 = 3389
      104 = 22
  }
}

resource "azurerm_network_security_rule" "regras_entrada_liberada" {
  for_each = var.regras_entrada
  resource_group_name = "vnetrg"
  name = "portaentrada_${each.value}"
  priority = each.key
  destination_port_range = each.value
  direction = "Inbound"
  access = "Allow"
  source_port_range = "*"
  protocol = "Tcp"
  source_address_prefix = "*"
  destination_address_prefix = "*"
  network_security_group_name = "treinamento-nsg"

}


