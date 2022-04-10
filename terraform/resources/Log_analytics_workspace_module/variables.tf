variable "location" {
  description = "Azure region "
}
# Logs
variable "storage_account_law" {

}
variable "log_analytics_workspace" {

}
variable "resource_group_law" {

}
variable "diag_setting_name" {

}
# diag settings for subscription
variable "subscription_name" {
  default = "SieSmart"
}
variable "diag_settingsub_name" {

}
# hubd nsg
variable "nsg_hubd_name" {
  default = "nsg-eu2-siesmart-hub-d-devops"
}
variable "rg_hubd_name" {
  default = "rg-eu2-siesmart-hub-d-transit"
}
# sharedp nsg
variable "nsg_sharedp_name" {
  default = "nsg-eu2-siesmart-hub-p-bastion"
}
variable "rg_sharedp_name" {
  default = "rg-eu2-siesmart-hub-p-shared"
}
# N/w watcher
variable "network_watcher_law" {
  default = "NetworkWatcher_westeurope"
}
variable "resource_group_nw" {
  default = "NetworkWatcherRG"
}
#
variable "st_account_id" {

  description = "The id of the storage account"
}
# Vnet_hub_transit Log
variable "hubtransitp_vnet_name" {
  default = "vnet-eu1-siesmart-hub-p-transit"
}
variable "hubtransitp_vnet_rg" {
  default = "rg-eu1-siesmart-hub-p-transit"
}
variable "diag_settingtransitpvnet_name" {

}
# Vnet_hub_shared Log
variable "hubsharedp_vnet_name" {
  default = "vnet-eu2-siesmart-hub-p-shared"
}
variable "hubsharedp_vnet_rg" {
  default = "rg-eu2-siesmart-hub-p-shared"
}
variable "diag_settingsharedpvnet_name" {

}
# vm log
variable "hubdvm_name" {
  default = "vm-eu2-siesmart-hub-d-devops"
}
variable "diag_settinghubdvm_name" {

}
# Firewall Log
variable "az_firewall_name" {
  default = "fw-eu1-siesmart-hub-p-firewall"
}
variable "az_firewall_rg" {
  default = "rg-eu1-siesmart-hub-p-transit"
}
variable "diag_settingfw_name" {

}
#  Tags
variable "tag_devopslawname" {}

variable "environment" {

}
variable "BusinessUnit" {
  default = "SFS"
}
variable "ApplicationName" {
  default = "SieSmart"
}
variable "ApproverName" {
  default = "anthony.olofsson@siemens.com"
}
variable "OwnerName" {
  default = "anthony.olofsson@siemens.com"
}
variable "DataClassification" {
  default = "Confidential"
}
variable "UPM-X-ID" {
  default = "79fc322eaaf611e1bcd0001e330da743"
}
variable "FACTS-ID" {
  default = ""
}
variable "ACP-Level" {
  default = "2-2-2"
}
variable "contact" {
  default = "Joakim Grenemark, Jose Franco, Björn Brännström"
}
