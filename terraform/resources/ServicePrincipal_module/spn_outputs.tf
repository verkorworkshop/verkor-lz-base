output "application_id" {
  value = azuread_service_principal.main.application_id
}

output "object_id" {
  value = azuread_service_principal.main.object_id
}
