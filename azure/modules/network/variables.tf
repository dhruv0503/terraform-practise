variable "location" {
    description = "Region where resources will be created"
    type = string
}

variable "address_space" {
    description = "The address space that is used by the virtual network."
    type = list(string)
}

variable "rg_name" {
    description = "Name of the resource group"
    type = string
}

variable "subnet_address_prefix" {
    description = "The address prefix to use for the subnet."
    type = list(string)
}

variable "ssh_source_address_prefix" {
    description = "The source address prefix for SSH access."
    type = string
}
