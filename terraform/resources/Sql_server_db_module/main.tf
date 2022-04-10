
#--- create  sql data base  
resource "azurerm_sql_database" "sqldb" {
  name                = var.sql_db_name
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = var.sql_server_name
}
