variable "rg_name" {
    description = "Name of the resource group"
    type = string
}

variable "location" {
    description = "Region where resources will be created"
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

variable "subnet_id" {
    description = "The ID of the subnet."
    type = string
}

variable "public_ip" {
    description = "The Public IP for the VM."
    type = string
}

variable "storage_account_name" {
    description = "The name of the storage account"
    type = string
}

variable "storage_account_key" {
    description = "The access key of the storage account"
    type = string 
}

variable "file_share_name" {
    description = "The name of the file share"
    type = string
}