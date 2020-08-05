# The variables below are common across the solution
variable "project_ident" {
  description = "2 or 3 letter project identifier"
}

variable "env_ident" {
  description = "Identifier for target environment such as dev, test, prod"
}
variable "region_suffix" {
  description = "Identifier for target environment such as dev, test, prod"
}
variable "sa_prefix" {
  description = "Name of the resource group to deploy uatelop stack into"
}
variable "location" {
  description = "Name of the resource group to deploy uatelop stack into"
}
variable "resource_group_name" {
  description = "Name of the resource group to deploy uatelop stack into"
}