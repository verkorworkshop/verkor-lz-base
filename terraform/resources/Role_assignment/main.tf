resource "azurerm_role_assignment" "roleassignment" {
  scope                = var.scope
  role_definition_name = var.role_definition_name
  principal_id         = var.object_id
}