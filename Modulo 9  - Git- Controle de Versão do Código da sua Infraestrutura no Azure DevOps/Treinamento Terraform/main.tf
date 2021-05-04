terraform {
  backend "azurerm" {
  }
}

provider "azurerm" {
  features{}
}

resource "azurerm_resource_group" "rg" {
    name = "rg-terraform-git-${terraform.workspace}"
    location = "brazilsouth"
    tags = {
      "ambiente" = terraform.workspace
    }
}

resource "azurerm_app_service_plan" "plan" {
  name = "appplan-azdevops-${terraform.workspace}"
  location = "brazilsouth"
  resource_group_name = "rg-terraform-git-${terraform.workspace}"
  tags = {
      "ambiente" = terraform.workspace
    }
  sku {
    size = "S1"
    tier = "Standard"
  }
}


resource "azurerm_app_service" "appservice" {
  name = "appserviceazdevopstrein-${terraform.workspace}"
  resource_group_name = "rg-terraform-git-${terraform.workspace}"
  location = "brazilsouth"
  app_service_plan_id = azurerm_app_service_plan.plan.id
  tags = {
      "ambiente" = terraform.workspace
    }
  site_config {
    dotnet_framework_version = "v4.0"
  }
}