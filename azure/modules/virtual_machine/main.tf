resource "azurerm_network_interface" "example_network_interface" {
  name                = "example_network_interface"
  location            = var.location
  resource_group_name = var.rg_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = var.public_ip
  }
}

resource "azurerm_linux_virtual_machine" "example_machine" {
  name                  = "test-VM"
  resource_group_name   = var.rg_name
  location              = var.location
  network_interface_ids = [azurerm_network_interface.example_network_interface.id]
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_ssh_key {
    username = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }
  os_disk {
    caching = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }
  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }
  custom_data = base64encode(templatefile(var.bootstrap_file_address, {
    storage_account_name = var.storage_account_name
    storage_account_key  = var.storage_account_key
    file_share_name      = var.file_share_name
  }))
}
