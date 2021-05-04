provider "azurerm" {
  features {}
}



resource "azurerm_resource_group" "rg" {
  name     = "rg-mariadb"
  location = "brazilsouth"
}

resource "azurerm_mariadb_server" "mariaserver" {
  name                = "mariadbservertf"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name                     = "B_Gen5_2"
  storage_mb                   = 51200
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false


  administrator_login          = "adminmariadb"
  administrator_login_password = "senha"
  version                      = "10.2"
  ssl_enforcement_enabled      = false
}

resource "azurerm_mariadb_database" "mariadb" {
  name                = "mariadbterraform"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mariadb_server.mariaserver.name
  charset             = "utf8"
  collation           = "utf8_general_ci"
}

data "http" "ip_address" {
  url = "https://api.ipify.org"
  request_headers = {
      Accept = "text/plan"
  }
}

resource "azurerm_mariadb_firewall_rule" "myip" {
  name = "personalip"
  resource_group_name = azurerm_resource_group.rg.name
  server_name = azurerm_mariadb_server.mariaserver.name
  start_ip_address = data.http.ip_address.body
  end_ip_address = data.http.ip_address.body
}

resource "azurerm_mariadb_firewall_rule" "allow-azservices" {
  name = "allow-azure-services"
  resource_group_name = azurerm_resource_group.rg.name
  server_name = azurerm_mariadb_server.mariaserver.name
  start_ip_address = "0.0.0.0"
  end_ip_address = "0.0.0.0"
}