
# The variables below are common across the solution
variable "project_ident" {
  description = "2 or 3 letter project identifier"
}

variable "env_ident" {
  description = "Identifier for target environment such as dev, test, prod"
}

variable "region_suffix" {
  description = "Name of the resource group to deploy develop stack into"
}

# Varaibles specific to this deploy ment

variable "resource_group_name" {
  description = "Name of the resource group to deploy resources into"
}

variable "location" {
  description = "Region to build resources in"
}

variable "vnet_address_space" {
  default = "10.1.0.0/16"
}

variable "subnet1_name" {
  description = "The name of the subnet to be created for admin-vm (dns server)"
  default     = "DMZ-Subnet-A"
}

variable "subnet1_network" {
  default = "10.1.1.0/24"
}

variable "subnet2_name" {
  description = "The name of subnet to be created for the tfs vm"
  default     = "App-Subnet-A"
}

variable "subnet2_network" {
  default = "10.1.2.0/24"
}

variable "subnet3_name" {
  description = "The name of subnet to be created for the dev stack VMs"
  default     = "DB-Subnet-A"
}

variable "subnet3_network" {
  default = "10.1.3.0/24"
}

variable "subnet4_name" {
  description = "The name of the subnet to be created for the App Service Environment"
  default     = "DMZ-Subnet-B"
}

variable "subnet4_network" {
  default = "10.1.4.0/24"
}

variable "subnet5_name" {
  description = "The name of the subnet to be created for the App Service Environment"
  default     = "App-Subnet-B"
}

variable "subnet5_network" {
  default = "10.1.5.0/24"
}

variable "subnet6_name" {
  description = "The name of the subnet to be created for the App Service Environment"
  default     = "DB-Subnet-B"
}

variable "subnet6_network" {
  default = "10.1.6.0/24"
}

variable "nsg1_name" {
  default = "DMZ-Subnet-NSG"
}

variable "nsg2_name" {
  default = "App-Subnet-NSG"
}

variable "nsg3_name" {
  default = "DB-Subnet-NSG"
}

