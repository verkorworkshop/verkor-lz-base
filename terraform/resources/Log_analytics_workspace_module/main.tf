data "azurerm_resource_group" "rg_hubd" {
  name = var.rg_hubd_name

}
data "azurerm_resource_group" "rg_sharedp" {
  name = var.rg_sharedp_name

}
# Networking components to be monitored
data "azurerm_network_security_group" "nsg_hubd_name" {
  name                = var.nsg_hubd_name
  resource_group_name = data.azurerm_resource_group.rg_hubd.name
}

resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace
  location            = var.location
  resource_group_name = var.resource_group_law
  retention_in_days   = 365
  daily_quota_gb      = 10
  tags = {
    Name               = var.tag_devopslawname
    BusinessUnit       = var.BusinessUnit
    ApplicationName    = var.ApplicationName
    DataClassification = var.DataClassification
    ApproverName       = var.ApproverName
    Environment        = var.environment
    OwnerName          = var.OwnerName
    contact            = var.contact
    "FACTS ID"         = var.FACTS-ID
    "UPM-X ID"         = var.UPM-X-ID
    "ACP-Level (CIA)"  = var.ACP-Level
  }
}
resource "azurerm_monitor_diagnostic_setting" "diag_setting" {
  name                       = var.diag_setting_name
  target_resource_id         = azurerm_log_analytics_workspace.log_analytics.id
  storage_account_id         = var.st_account_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
  log {
    category = "Audit"
    enabled  = true
    retention_policy {
      enabled = true
      days    = 365
    }
  }


  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = 30
    }
  }
}
# Logs
data "azurerm_network_watcher" "default" {
  name                = var.network_watcher_law
  resource_group_name = var.resource_group_nw
}
resource "azurerm_network_watcher_flow_log" "network_logs" {
  network_watcher_name = var.network_watcher_law
  resource_group_name  = var.resource_group_nw

  network_security_group_id = data.azurerm_network_security_group.nsg_hubd_name.id
  storage_account_id        = var.st_account_id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 365
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.log_analytics.workspace_id
    workspace_region      = azurerm_log_analytics_workspace.log_analytics.location
    workspace_resource_id = azurerm_log_analytics_workspace.log_analytics.id
    interval_in_minutes   = 10
  }
}
# Firewall Logs (northeurope)
data "azurerm_firewall" "az_firewall" {
  name                = var.az_firewall_name
  resource_group_name = var.az_firewall_rg
}
resource "azurerm_monitor_diagnostic_setting" "diag_setting_fw" {
  name                       = var.diag_settingfw_name
  target_resource_id         = data.azurerm_firewall.az_firewall.id
  storage_account_id         = var.st_account_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
  log {
    category = "AzureFirewallApplicationRule" #,"AzureFirewallNetworkRule","AzureFirewallDnsProxy"]
    enabled  = true
    retention_policy {
      enabled = true
      days    = 365
    }
  }
  log {
    category = "AzureFirewallNetworkRule"
    enabled  = true
    retention_policy {
      enabled = true
      days    = 365
    }
  }
  log {
    category = "AzureFirewallDnsProxy"
    enabled  = true
    retention_policy {
      enabled = true
      days    = 365
    }
  }
  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = 30
    }
  }
}
# Vnet Logs (northeurope)
data "azurerm_virtual_network" "hubtransitp_vnet" {
  name                = var.hubtransitp_vnet_name
  resource_group_name = var.hubtransitp_vnet_rg
}
resource "azurerm_monitor_diagnostic_setting" "diag_setting_transitpvnet" {
  name                       = var.diag_settingtransitpvnet_name
  target_resource_id         = data.azurerm_virtual_network.hubtransitp_vnet.id
  storage_account_id         = var.st_account_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
  log {
    category = "VMProtectionAlerts"
    enabled  = true
    retention_policy {
      enabled = true
      days    = 365
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = 30
    }
  }
}
# Vnet Logs (westeurope)
data "azurerm_virtual_network" "hubsharedp_vnet" {
  name                = var.hubsharedp_vnet_name
  resource_group_name = var.hubsharedp_vnet_rg
}
resource "azurerm_monitor_diagnostic_setting" "diag_setting_sharedpvnet" {
  name                       = var.diag_settingsharedpvnet_name
  target_resource_id         = data.azurerm_virtual_network.hubsharedp_vnet.id
  storage_account_id         = var.st_account_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
  log {
    category = "VMProtectionAlerts"
    enabled  = true
    retention_policy {
      enabled = true
      days    = 365
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = 30
    }
  }
}
# hubd vm
data "azurerm_virtual_machine" "hubdvm" {
  name                = var.hubdvm_name
  resource_group_name = data.azurerm_resource_group.rg_hubd.name
}
resource "azurerm_monitor_diagnostic_setting" "diag_setting_hubdvm" {
  name                       = var.diag_settinghubdvm_name
  target_resource_id         = data.azurerm_virtual_machine.hubdvm.id
  storage_account_id         = var.st_account_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
  /* log {
  category = "WorkflowRuntime"
  enabled = "true"

retention_policy {
  enabled = "true"
  days    = "365"
  }
} */

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = 30
    }
  }
}
# Diag settings for subscription
data "azurerm_subscription" "current" {
}
resource "azurerm_monitor_diagnostic_setting" "diag_setting_sub" {
  name                       = var.diag_settingsub_name
  target_resource_id         = data.azurerm_subscription.current.id
  storage_account_id         = var.st_account_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
  log {
    category = "Security"
    enabled  = "true"

    retention_policy {
      enabled = "true"
      days    = "365"
    }
  }
  log {
    category = "Administrative"
    enabled  = "true"

    retention_policy {
      enabled = "true"
      days    = "365"
    }
  }
  log {
    category = "ServiceHealth"
    enabled  = "true"

    retention_policy {
      enabled = "true"
      days    = "365"
    }
  }
  log {
    category = "Alert"
    enabled  = "true"

    retention_policy {
      enabled = "true"
      days    = "365"
    }
  }
  log {
    category = "Recommendation"
    enabled  = "true"

    retention_policy {
      enabled = "true"
      days    = "365"
    }
  }
  log {
    category = "Policy"
    enabled  = "true"

    retention_policy {
      enabled = "true"
      days    = "365"
    }
  }
  log {
    category = "Autoscale"
    enabled  = "true"

    retention_policy {
      enabled = "true"
      days    = "365"
    }
  }
  log {
    category = "ResourceHealth"
    enabled  = "true"

    retention_policy {
      enabled = "true"
      days    = "365"
    }
  }
}
