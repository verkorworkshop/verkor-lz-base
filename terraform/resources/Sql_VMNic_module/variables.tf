variable "resource_group_name" {

}

variable "location" {

}

variable "virtual_network_name" {

}

variable "vm_vmnic_SQL" {

}


variable "environment" {

}

variable "subnet_data_id" {

}

variable "private_ip_address_allocation" {
  description = "Azure vm vm private ip allocation method"
  default     = "Dynamic"
}

variable "region" {

}


variable "env" {
  default = ""
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
variable "tag_vmnicsql" {

}

