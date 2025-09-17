terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_public_ip" "example_public_ip"{
    name = "example-public-ip"
    resource_group_name = azurerm_resource_group.example.name
    location = var.location
    allocation_method = var.public_ip_allocation_method
    sku = var.public_ip_sku
}

module "network" {
  source = "./modules/network"
  address_space = var.address_space
  rg_name = azurerm_resource_group.example.name
  location = azurerm_resource_group.example.location
  subnet_address_prefix = var.subnet_address_prefix
  ssh_source_address_prefix = var.ssh_source_address_prefix
}

module "virtual_machine" {
  source = "./modules/virtual_machine"
  rg_name = azurerm_resource_group.example.name
  location = azurerm_resource_group.example.location
  subnet_id = module.network.subnet_id
  public_ip = azurerm_public_ip.example_public_ip.id
  vm_size = var.vm_size
  admin_username = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path
  os_disk_caching = var.os_disk_caching
  os_disk_storage_account_type = var.os_disk_storage_account_type
  source_image_offer = var.source_image_offer
  source_image_publisher = var.source_image_publisher
  source_image_sku = var.source_image_sku
  source_image_version = var.source_image_version
  bootstrap_file_address = var.bootstrap_file_address
}


# resource "azurerm_managed_disk" "example_disk" {
#   name                 = "example-disk"
#   location             = var.location
#   resource_group_name  = azurerm_resource_group.example.name
#   storage_account_type = "Standard_LRS"
#   create_option        = "Empty"
#   disk_size_gb        = 10
# }