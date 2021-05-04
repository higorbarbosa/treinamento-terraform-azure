provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = "rg-mysql"
  location = "brazilsouth"
}

resource "azurerm_mysql_server" "mysqlserver" {
  name                = "mysqldbservertf"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name                     = "B_Gen5_2"
  storage_mb                   = 5120
  version                      = "5.7"
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  administrator_login          = "adminmysqldb"
  administrator_login_password = "senha"

  infrastructure_encryption_enabled = false
  ssl_enforcement_enabled           = false
  public_network_access_enabled     = true
  auto_grow_enabled                 = true

}


resource "azurerm_mysql_database" "mysqldb" {
  name                = "mysqldb-terraform"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.mysqlserver.name
  charset             = "utf8"
  collation           = "utf8_general_ci"

}

data "http" "ip_address" {
  url = "https://api.ipify.org"
  request_headers = {
      Accept = "text/plan"
  }
}

resource "azurerm_mysql_firewall_rule" "myip" {
  name = "personalip"
  resource_group_name = azurerm_resource_group.rg.name
  server_name = azurerm_mysql_server.mysqlserver.name
  start_ip_address = data.http.ip_address.body
  end_ip_address = data.http.ip_address.body
}

resource "azurerm_mysql_firewall_rule" "allow-azservices" {
  name = "allow-azure-services"
  resource_group_name = azurerm_resource_group.rg.name
  server_name = azurerm_mysql_server.mysqlserver.name
  start_ip_address = "0.0.0.0"
  end_ip_address = "0.0.0.0"
}



