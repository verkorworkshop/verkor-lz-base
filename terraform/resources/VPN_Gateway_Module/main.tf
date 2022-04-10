#############################################################################
# DATA
#############################################################################

data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

locals {
  namelist       = split("-", data.azurerm_resource_group.resource_group.name)
  namevalidation = length(local.namelist) == 4 ? "true" : "false"
  defaultname    = local.namevalidation == "true" ? "${local.namelist[0]}-vpn-gateway-${var.zone}-${var.environment}" : ""
}

resource "azurerm_virtual_network_gateway" "azure_vpn_gateway" {
  name                = var.vpn_gateway_name == "" ? local.defaultname : var.vpn_gateway_name
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = var.sku
  tags          = var.tags
  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = var.vpn_gateway_public_ip_id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_vpn_gateway_id
  }

}