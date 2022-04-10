terraform {
  required_version = "0.12.6"
}

provider "azurerm" {
  version = "=1.32.0"
}

resource "azuread_application" "main" {
  name = "var.azuread_application_name"
}

resource "azuread_service_principal" "main" {
  application_id = azuread_application.main.application_id
}