provider "azurerm" {
  features {}

}


resource "azurerm_resource_group" "grupo-recurso" {
  name = "rgterraform"
  location = "brazilsouth"
}