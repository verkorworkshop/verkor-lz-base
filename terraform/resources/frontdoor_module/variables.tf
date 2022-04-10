variable "location" {
  description = "Azure region where the storage account will be located"
}
variable "region" {
  description = "Azure region where the storage account will be located"
}
variable "resource_group_name" {
  description = "Name of the resource group where the storage account belongs"
}
variable "env" {

}
variable "front-door-object" {
  description = "Name of the resource group where the storage account belongs"
}
variable "location_frontdoor" {
  default = "global"
}

variable "front-door-waf-object" {
  description = "(Required) AFD Settings of the Azure  Front Door to be created"
}
variable "tag_fdname" {

}
variable "environment" {
  description = "Azure Env"
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
variable "create_frontdoor" {
  description = "Whether to create resource group and use it for all networking resources"
  default     = "true"
}