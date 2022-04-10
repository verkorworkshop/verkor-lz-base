variable "location" {
  type        = string
  description = "Resources location in Azure"
}
variable "region" {
  type        = string
  description = "Resources region in Azure"
}

###################################################
# TAGs
###################################################
variable "customer" {
  type = string
}
variable "environment" {
  type = string
}
variable "environment_short" {
  type = string
}
variable "business_unit" {
  type = string
}
variable "applicationname" {
  type = string
}
variable "applicationname_short" {
  type = string
}
variable "approver_name" {
  type = string
}
variable "owner_name" {
  type = string
}
variable "data_classification" {
  type = string
}
variable "contact" {
  type = string
}
