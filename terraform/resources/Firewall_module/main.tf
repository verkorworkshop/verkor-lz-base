data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

locals {
  namelist       = split("-", data.azurerm_resource_group.resource_group.name)
  namevalidation = length(local.namelist) == 4 ? "true" : "false"
  defaultname    = local.namevalidation == "true" ? "${local.namelist[0]}-fw-${var.zone}-${var.environment}" : ""

  fw_nat_rules = { for idx, rule in var.firewall_nat_rules : rule.name => {
    idx : idx,
    rule : rule,
    }
  }

  fw_network_rules = { for idx, rule in var.firewall_network_rules : rule.name => {
    idx : idx,
    rule : rule,
    }
  }

  fw_application_rules = { for idx, rule in var.firewall_application_rules : rule.name => {
    idx : idx,
    rule : rule,
    }
  }
}

/* resource "azurerm_firewall_policy" "main" {
  count               = var.firewall_policy != null ? 1 : 0
  name                = var.firewall_policy.name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  base_policy_id      = var.firewall_policy.base_policy_id
  sku                 = var.firewall_policy.sku

  dynamic "dns" {
    for_each = var.firewall_policy.dns != null ? [var.firewall_policy.dns] : []
    content {
      servers       = dns.value.servers
      proxy_enabled = dns.value.proxy_enabled
    }
  }
  dynamic "threat_intelligence_allowlist" {
    for_each = var.firewall_policy.threat_intelligence_allowlist != null ? [var.firewall_policy.threat_intelligence_allowlist] : []
    content {
      ip_addresses = threat_intelligence_allowlist.value.ip_addresses
      fqdns        = threat_intelligence_allowlist.value.fqdns
    }
  }
  # tags = var.tags
} */

resource "azurerm_firewall" "azure_firewall" {
  name                = var.firewall_name == "" ? local.defaultname : var.firewall_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  sku_tier            = var.sku_tier
  sku_name            = var.sku_name
  threat_intel_mode   = var.threat_intel_mode
  dns_servers         = var.dns_servers
  /* firewall_policy_id  = azurerm_firewall_policy.main.0.id */

  ip_configuration {
    name                 = "core-azure-firewall-config"
    subnet_id            = var.subnet_firewall_id
    public_ip_address_id = var.firewall_public_ip_id
  }
  tags = var.tags
  /* depends_on = [
    azurerm_firewall_policy.main
  ] */
}

#----------------------------------------------
# Azure Firewall Network/Application/NAT Rules 
#----------------------------------------------
resource "azurerm_firewall_application_rule_collection" "fw_app" {
  for_each            = local.fw_application_rules
  name                = lower(format("fw-app-rule-%s-${azurerm_firewall.azure_firewall.name}", each.key))
  azure_firewall_name = azurerm_firewall.azure_firewall.name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  priority            = 100 * (each.value.idx + 1)
  action              = each.value.rule.action

  rule {
    name             = each.key
    description      = each.value.rule.description
    source_addresses = each.value.rule.source_addresses
    source_ip_groups = each.value.rule.source_ip_groups
    fqdn_tags        = each.value.rule.fqdn_tags
    target_fqdns     = each.value.rule.target_fqdns

    protocol {
      type = each.value.rule.protocol.type
      port = each.value.rule.protocol.port
    }
  }
  depends_on = [
    azurerm_firewall.azure_firewall
  ]
}

resource "azurerm_firewall_network_rule_collection" "fw_nw" {
  for_each            = local.fw_network_rules
  name                = lower(format("fw-net-rule-%s-${azurerm_firewall.azure_firewall.name}", each.key))
  azure_firewall_name = azurerm_firewall.azure_firewall.name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  priority            = 100 * (each.value.idx + 1)
  action              = each.value.rule.action

  rule {
    name                  = each.key
    description           = each.value.rule.description
    source_addresses      = each.value.rule.source_addresses
    destination_ports     = each.value.rule.destination_ports
    destination_addresses = each.value.rule.destination_addresses
    destination_fqdns     = each.value.rule.destination_fqdns
    protocols             = each.value.rule.protocols
  }
  depends_on = [
    azurerm_firewall.azure_firewall
  ]
}

resource "azurerm_firewall_nat_rule_collection" "fw_nat" {
  for_each            = local.fw_nat_rules
  name                = lower(format("fw-nat-rule-%s-${azurerm_firewall.azure_firewall.name}", each.key))
  azure_firewall_name = azurerm_firewall.azure_firewall.name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  priority            = 100 * (each.value.idx + 1)
  action              = each.value.rule.action

  rule {
    name                  = each.key
    description           = each.value.rule.description
    source_addresses      = each.value.rule.source_addresses
    destination_ports     = each.value.rule.destination_ports
    destination_addresses = each.value.rule.destination_addresses
    protocols             = each.value.rule.protocols
    translated_address    = each.value.rule.translated_address
    translated_port       = each.value.rule.translated_port
  }
  depends_on = [azurerm_firewall.azure_firewall]
}
