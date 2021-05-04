terraform {
  backend "azurerm" {
    resource_group_name = "terraformstate"
    storage_account_name = "tfstateaztreinamento"
    container_name = "terraformstate"
    key = "chave"
    }
}

provider "azurerm" {
  features{}
}

variable "location" {
  type = "string"
  default = "brazilsouth"
}

resource "azurerm_resource_group" "rg" {
  name = "appservice-${lower(terraform.workspace)}"
  location = var.location
}

resource "azurerm_app_service_plan" "plan" {
  name = "appserviceplan${lower(terraform.workspace)}"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appservice" {
  name = "tfappservicem-${lower(terraform.workspace)}"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    dotnet_framework_version = "v4.0"
  }

  app_settings = {
    "chave" = "123456"
  }
}
