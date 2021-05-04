provider "azurerm" {
  features {
  }
}


resource "azurerm_resource_group" "rg" {
  name     = "rg-scan"
  location = "brazilsouth"
}

resource "azurerm_app_service_plan" "plan" {
  name                = "appplanscan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    size = "F1"
    tier = "Standard"
  }
}


resource "azurerm_app_service" "appservice" {
  name                = "appservicescantf"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id
  client_cert_enabled = true

  site_config {
    http2_enabled   = true
    min_tls_version = "1.2"
  }
}