# The variables below are common across the solution
variable "project_ident" {
  description = "2 or 3 letter project identifier"
}

variable "env_ident" {
  description = "Identifier for target environment such as dev, test, prod"
}

variable "region" {
  description = "Identifier for target environment such as dev, test, prod"
  default     = "usgovvirginia"
}

variable "region_suffix" {
  description = "Identifier for target environment such as dev, test, prod"
}

variable "subscription_Id" {
  description = "The ID of the subscription to deploy into"
}

variable "tenant_id" {
  description = "The ID of the tenant to deploy into"
}

variable "tf_sp_appid" {
  description = "The client_id of the service principal used to do the deployment"
}

variable "tf_sp_secret" {
  description = "The client_secret of the service principal used to do the deployment"
}

variable "tfstate_container_prefix" {
  description = "The prefix appended to the beginning of teh blob container name"
  default     = "terraform-state"
}

variable "tfstate_suffix" {
  description = "The suffix to append the end of each state file name"
  default     = "terraform.tfstate"
}

variable "tfstate_storage_suffix" {
  description = "The suffix to be appended to the end of the storage account name"
  default     = "tfstate"
}

variable "tfstate_access_key" {
  description = "The access key for the state file storage account"
}

variable "core_rg_name" {
  description = "Name of the resource group to deploy develop stack into"
  default     = "core-rg"
}

variable "sa_prefix" {
  description = "Name of the resource group to deploy develop stack into"
}