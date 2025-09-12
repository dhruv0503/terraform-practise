variable "location" {
    description = "Region where resources will be created"
    type = string
    default = "West Europe"
}

variable "address_space" {
    description = "The address space that is used by the virtual network."
    type = list(string)
    default = ["10.0.0.0/16"]
}

variable "rg_name" {
    description = "Name of the resource group"
    type = string
    default = "example-resources"
}
