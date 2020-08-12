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

variable "laws_sku" {
  description = "The sku size for the log Analytics workspace Possible values are Free,
   PerNode, Premium, Standard, Standalone, Unlimited, and PerGB2018"
  default   = "Standard"
}

variable "retention_in_days" {
  description = "The workspace data retention in days. Possible values are,
  either 7 (Free Tier only) or range between 30 and 730."
  default     = 180
}

variable "location" {
  description = "supported Azure location where the resource exists"
}

variable "resource_group_name" {
  description = "The name of the resource group in which the Log Analytics workspace is created"
}