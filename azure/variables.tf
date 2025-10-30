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
variable "vm_size" {
    description = "Size of the VM"
    type = string
}

variable "admin_username" {
    description = "Admin username for the VM"
    type = string
}

variable "ssh_public_key_path" {
    description = "Path to the SSH public key"
    type = string
}

variable "os_disk_caching" {
    description = "The caching type of the OS disk."
    type = string
}

variable "os_disk_storage_account_type" {
    description = "The storage account type of the OS disk."
    type = string
}

variable "source_image_publisher" {
    description = "The publisher of the source image."
    type = string
}

variable "source_image_offer" {
    description = "The offer of the source image."
    type = string
}

variable "source_image_sku" {
    description = "The SKU of the source image."
    type = string
}

variable "source_image_version" {
    description = "The version of the source image."
    type = string
}

variable "bootstrap_file_address" {
    description = "Path to the bootstrap file."
    type = string
}

variable "public_ip_allocation_method" {
    description = "Public IP allocation method"
    type = string
}

variable "public_ip_sku" {
    description = "Public IP SKU"
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

variable "storage_account_type" {
  description = "The type of storage account to create."
  type        = string
}

variable "storage_replication_tier" {
  description = "Tier of replication of data in storage account"
  type = string
}

variable "sample_file_path" {
  description = "Path to the sample file for blob storage"
  type = string
}
