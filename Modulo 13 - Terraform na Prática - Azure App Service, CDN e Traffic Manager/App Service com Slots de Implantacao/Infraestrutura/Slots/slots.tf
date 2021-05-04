terraform {
  backend "azurerm" {}
}

provider "azurerm" {
    features {} 
}

resource "azurerm_resource_group" "rg" {
  name = var.rg-nome
  location = "brazilsouth"
}




resource "azurerm_app_service_plan" "plan" {
  name = var.appplan-nome
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}


resource "azurerm_app_service" "appservice" {
  name = var.appservice-nome
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id
}


resource "azurerm_app_service_slot" "slot" {
  name = var.slot-nome
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_name = azurerm_app_service.appservice.name
  app_service_plan_id = azurerm_app_service_plan.plan.id

}