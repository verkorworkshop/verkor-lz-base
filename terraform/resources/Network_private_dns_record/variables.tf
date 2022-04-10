variable "private_endpoint_dns_zone_record_name" {
  description = "Name of private endpoint DNS Zone record"
}

variable "resource_group_name" {
  description = "Name of the resource group where the storage account belongs"
}

variable "private_endpoint_dns_zone_name" {
  description = "Name of private endpoint DNS Zone name"
}

variable "time_to_live" {
  description = "Time to live in secs"
}

variable "records_set_private_ip_name" {
  description = "Records set entry of private ip in DNS zone"
}
