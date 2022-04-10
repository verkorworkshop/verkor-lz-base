terraform {
  experiments = [module_variable_optional_attrs]
}
variable "resource_group_name" {
  type        = string
  description = "Name of resource group where firewall will be created"
}

variable "environment" {
  type        = string
  description = "The environment denotation.d=Development, t=Test, a=Acceptance, p=Production, dt=Dev-Test, ap=Acceptance-Production"
  default     = "d"
}

variable "zone" {
  type        = string
  description = "Enter abbreviation for Zone. e=External, i=Internal, m=Management"
  default     = "i"
}
variable "firewall_name" {
  type        = string
  description = "firewall name"
}

variable "virtual_network_name" {
  type        = string
  description = "virtual network name"
}

variable "subnet_firewall_id" {
  type        = string
  description = "firewall sub net"
}

variable "firewall_public_ip_id" {
  type        = string
  description = "firewall sub net"
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resources."
  default     = {}
}

variable "sku_tier" {
  description = "Sku tier of the Firewall. Possible values are Premium and Standard"
  default     = "Standard"
}

variable "sku_name" {
  description = "Sku name of the Firewall. Possible values are AZFW_Hub and AZFW_VNet"
  default     = "AZFW_VNet"
}

variable "threat_intel_mode" {
  description = "The operation mode for threat intelligence-based filtering. Possible values are: Off, Alert,Deny and empty string. Defaults to Alert"
  default     = "Alert"
}

variable "dns_servers" {
  description = "A list of DNS servers that the Azure Firewall will direct DNS traffic to the for name resolution."
  type        = list(string)
  default     = null
}
/* variable "firewall_policy" {
  description = "Manages a Firewall Policy resource that contains NAT, network, and application rule collections, and Threat Intelligence settings"
  type = object({
    name                     = optional(string)
    sku                      = optional(string)
    base_policy_id           = optional(string)
    threat_intelligence_mode = optional(string)
    dns = optional(object({
      servers       = list(string)
      proxy_enabled = bool
    }))
    threat_intelligence_allowlist = optional(object({
      ip_addresses = list(string)
      fqdns        = list(string)
    }))
  })
  default = null
} */

#Firewall Rules
variable "firewall_application_rules" {
  description = "Microsoft-managed virtual network that enables connectivity from other resources."
  type = list(object({
    name             = string
    description      = optional(string)
    action           = string
    source_addresses = optional(list(string))
    source_ip_groups = optional(list(string))
    fqdn_tags        = optional(list(string))
    target_fqdns     = optional(list(string))
    protocol = optional(object({
      type = string
      port = string
    }))
  }))
  default = []
}

variable "firewall_network_rules" {
  description = "List of network rules to apply to firewall."
  type = list(object({
    name                  = string
    description           = optional(string)
    action                = string
    source_addresses      = optional(list(string))
    destination_ports     = list(string)
    destination_addresses = optional(list(string))
    destination_fqdns     = optional(list(string))
    protocols             = list(string)
  }))
  default = []
}

variable "firewall_nat_rules" {
  description = "List of nat rules to apply to firewall."
  type = list(object({
    name                  = string
    description           = optional(string)
    action                = string
    source_addresses      = optional(list(string))
    destination_ports     = list(string)
    destination_addresses = list(string)
    protocols             = list(string)
    translated_address    = string
    translated_port       = string
  }))
  default = []
}
