resource "azurerm_virtual_network" "example_network" {
  name                = "example-network"
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "example_subnet" {
  name                 = "example-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.example_network.name
  address_prefixes     = var.subnet_address_prefix
}

resource "azurerm_network_security_group" "example_nsg" {
    name = "example-nsg"
    location = var.location
    resource_group_name = var.rg_name
}

resource "azurerm_network_security_rule" "allow_ssh" {
    resource_group_name = var.rg_name
    network_security_group_name = azurerm_network_security_group.example_nsg.name
    name = "allow-ssh"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = var.ssh_source_address_prefix
    destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "allow_http" {
    resource_group_name = var.rg_name
    network_security_group_name = azurerm_network_security_group.example_nsg.name
    name = "allow-http"
    priority = 200
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "80"
    source_address_prefix = "*" 
    destination_address_prefix = "*"
}

resource "azurerm_subnet_network_security_group_association" "example_assocation"{
    subnet_id = azurerm_subnet.example_subnet.id
    network_security_group_id = azurerm_network_security_group.example_nsg.id
}

output "subnet_id" {
    value = azurerm_subnet.example_subnet.id
}

output "nsg_id" {
    value = azurerm_network_security_group.example_nsg.id
}