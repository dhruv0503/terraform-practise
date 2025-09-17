output "resource_group_name" {
  description = "The name of the Resource Group created."
  value       = azurerm_resource_group.example.name
}

output "Public_IP" {
  description = "Public IP of VM"
  value = azurerm_public_ip.example_public_ip.ip_address
}