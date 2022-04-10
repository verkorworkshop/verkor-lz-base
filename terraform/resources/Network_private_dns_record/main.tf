
# ---- create private endpoint DNS record set

resource "azurerm_private_dns_a_record" "private_endpoint_a_record" {
  name                = var.private_endpoint_dns_zone_record_name
  zone_name           = var.private_endpoint_dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = var.time_to_live
  records             = [var.records_set_private_ip_name]
}
