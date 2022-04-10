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
variable "vpn_gateway_name" {
  type        = string
  description = "vpn gateway name"
}

variable "sku" {
  description = "The SKU of the VPN Gateway. The allowed Skus are VpnGw1AZ,VpnGw2AZ,VpnGw3AZ,VpnGw4AZ,VpnGw5AZ,VpnGw1,VpnGw2,VpnGw3,VpnGw4,VpnGw5 with DeploymentType VMScaleSet"
  type        = string
  default     = "VpnGw1AZ"
}

variable "virtual_network_name" {
  type        = string
  description = "virtual network name"
}

variable "subnet_vpn_gateway_id" {
  type        = string
  description = "firewall sub net"
}

variable "vpn_gateway_public_ip_id" {
  type        = string
  description = "firewall sub net"
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resources."
  default     = {}
}



