variable "location" {
    description = "Region where resources will be created"
    type = string
}

variable "rg_name" {
    description = "Name of the resource group"
    type = string
}

variable "storage_account_tier" {
  description = "Tier of Storage Account"
  type = string
}

variable "storage_replication_tier" {
  description = "Tier of replication of data in the storage account"
    type = string
}

variable "sample_file_path" {
  description = "Path to the sample file to be uploaded as blob"
  type = string
}

variable subnet_id {
  description = "The ID of the subnet where the storage account will be accessible from"
  type = string
}