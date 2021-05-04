resource "azurerm_resource_group" "rg" {
  name = var.rg
  location = var.location
}


resource "azurerm_app_service_plan" "plan" {
  name = "appserviceplantf"
  location = var.location
  resource_group_name = var.rg

    sku {
      tier = "Standard"
      size = "S1" 
    }
}


resource "azurerm_app_service" "appservice" {
    name = "azapptftreinamento"
    resource_group_name = var.rg
    location = var.location
    app_service_plan_id = azurerm_app_service_plan.plan.id

    site_config {
      dotnet_framework_version = "v4.0"
    }
    
    app_settings = {
      "chave" = "654321"
    }
}