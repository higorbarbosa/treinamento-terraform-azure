provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-aci"
  location = "brazilsouth"
}


resource "azurerm_container_group" "aci" {
  name                = "aci-sitetreinamentotf"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_address_type = "public"
  dns_name_label  = "aci-sitetreinamentotf"
  os_type         = "Linux"

  image_registry_credential {
    username = "acregistrytf"
    password = "senha"
    server   = "acregistrytf.azurecr.io"
  }

  container {
    name   = "acregistrytf"
    image  = "acregistrytf.azurecr.io/containersnoazure:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 443
      protocol = "TCP"
    }

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}