provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-webappcontainer"
  location = "brazilsouth"
}

resource "azurerm_app_service_plan" "plan" {
  name                = "appplancontainer"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  kind     = "Linux"
  reserved = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}


resource "azurerm_app_service" "appservicecontainer" {
  name                = "appservicecontainertf"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    linux_fx_version = "DOCKER|acregistrytf.azurecr.io/containersnoazure:latest"
    always_on        = true
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = false
    "DOCKER_REGISTRY_SERVER_URL"          = "acregistrytf.azurecr.io"
    "DOCKER_REGISTRY_SERVER_USERNAME"     = "acregistrytf"
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = "senha"
  }

  identity {
    type = "SystemAssigned"
  }
}