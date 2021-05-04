resource "azurerm_container_registry" "acr" {
  name                = "acrregistrytf"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  sku           = "Basic"
  admin_enabled = true
}

output "acr_usuario" {
  value = azurerm_container_registry.acr.admin_username
}

output "acr_senha" {
  value = azurerm_container_registry.acr.admin_password
}

output "acr_url" {
  value = azurerm_container_registry.acr.login_server
}