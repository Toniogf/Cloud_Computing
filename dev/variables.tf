variable "location" {}
variable "resource_group_name" {}
variable "acr_name" {}
variable "webapp_name" {}
variable "mysql_name" {}
variable "mysql_admin" {}
variable "mysql_password" {
  sensitive = true
}
