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

resource "azurerm_virtual_network" "example_network" {
  name                = "example-network"
  address_space       = var.address_space
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example_subnet" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "example_nsg" {
    name = "example-nsg"
    location = var.location
    resource_group_name = azurerm_resource_group.example.name

    security_rule {
        name = "allow-ssh"
        priority = 100
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = "*" 
        destination_address_prefix = "*"
    }
}

resource "azurerm_subnet_network_security_group_association" "example_assocation"{
    subnet_id = azurerm_subnet.example_subnet.id
    network_security_group_id = azurerm_network_security_group.example_nsg.id
}

resource "azurerm_public_ip" "example_public_ip"{
    name = "example-public-ip"
    resource_group_name = azurerm_resource_group.example.name
    location = var.location
    allocation_method = "Static"
    sku = "Standard"
}

resource "azurerm_network_interface" "example_network_interface" {
  name                = "example_network_interface"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.example_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "example_machine" {
  name                  = "test-VM"
  resource_group_name   = azurerm_resource_group.example.name
  location              = var.location
  network_interface_ids = [azurerm_network_interface.example_network_interface.id]
  size                  = "Standard_F2"
  admin_username        = "adminuser"
  admin_ssh_key {
    username = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  custom_data = filebase64("./cloud-init.txt")
}