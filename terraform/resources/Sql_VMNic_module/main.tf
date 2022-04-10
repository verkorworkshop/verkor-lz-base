

resource "azurerm_network_interface" "sqlvmnic" {
  name                = var.vm_vmnic_SQL
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = {
    Name               = var.tag_vmnicsql
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
  ip_configuration {
    name                          = "sqlserverNicConfiguration"
    subnet_id                     = var.subnet_data_id
    private_ip_address_allocation = var.private_ip_address_allocation

  }
}
