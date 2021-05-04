terraform {
    backend "azurerm" {
    }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
    name = "rg-terraform-pipeline-${terraform.workspace}"
    location = var.location
    tags = merge(var.tags, {"workspace" = "${terraform.workspace}"})
}

resource "azurerm_app_service_plan" "plan" {
    name = "appplan-azpipeline-${terraform.workspace}"
    location = var.location
    tags = merge(var.tags, {"workspace" = "${terraform.workspace}"})
    resource_group_name = azurerm_resource_group.rg.name
    sku {
      size = "F1"
      tier = "Standard"
    }
}

resource "azurerm_app_service" "appservice" {
    name = "azpipetreinamento-${terraform.workspace}"
    location = var.location
    tags = merge(var.tags, {"workspace" = "${terraform.workspace}"})
    resource_group_name = azurerm_resource_group.rg.name
    app_service_plan_id = azurerm_app_service_plan.plan.id
}