provider "azurerm" {
  features {
  }
}


data "azurerm_key_vault" "getkeyvault" {
  name                = "keyvaulttf"
  resource_group_name = "rg-keyvault"
}

data "azurerm_key_vault_secret" "secretget" {
  name         = "secret-terraform"
  key_vault_id = data.azurerm_key_vault.getkeyvault.id
}

output "secret" {
  value = data.azurerm_key_vault_secret.secretget.value
}
