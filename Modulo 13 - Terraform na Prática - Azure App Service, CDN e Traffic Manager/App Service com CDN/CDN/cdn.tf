terraform {
  backend "azurerm" {}
}


provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-cdn"
  location = "brazilsouth"

}


resource "azurerm_app_service_plan" "plan" {
  name                = "appplan-cdn"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}


resource "azurerm_app_service" "appservice" {
  name                = "appservicecdntf"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id
}


resource "azurerm_cdn_profile" "cdnprofile" {
  name                = "cdnprofile"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_Microsoft"
}


resource "azurerm_cdn_endpoint" "cdnendpoint" {
  name                = "appservicecdntf-cdn"
  profile_name        = azurerm_cdn_profile.cdnprofile.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  origin_host_header = azurerm_app_service.appservice.default_site_hostname

  origin {
    name      = azurerm_app_service.appservice.name
    host_name = azurerm_app_service.appservice.default_site_hostname
  }

  delivery_rule {
    name  = "EnforceHTTPS"
    order = "1"

    request_scheme_condition {
      operator     = "Equal"
      match_values = ["HTTP"]
    }

    url_redirect_action {
      redirect_type = "Found"
      protocol      = "Https"
    }
  }
}




