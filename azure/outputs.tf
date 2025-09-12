output "resource_group_name" {
  description = "The name of the Resource Group created."
  value       = azurerm_resource_group.example.name
}

output "virtual_network_id" {
  description = "The ID of the Virtual Network created."
  value       = azurerm_virtual_network.example_network.id
}

output "subnet_id" {
    description = "ID of subnet assigned to VM"
    value = azurerm_subnet.example_subnet.id
}

output "network_interface_id" {
    description = "ID of network interface assigned to VM"
    value = azurerm_network_interface.example_network_interface.id
}

output "VM_ID" {
    description = "ID of VM created"
    value = azurerm_linux_virtual_machine.example_machine.id
}

output "Public_IP" {
  description = "Public IP of VM"
  value = azurerm_public_ip.example_public_ip.ip_address
}