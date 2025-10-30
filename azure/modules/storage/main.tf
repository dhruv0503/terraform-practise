
resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}

resource "azurerm_storage_account" "test_storage_account" {
  name                 = "tfstorage${random_integer.suffix.result}"
  location             = var.location
  resource_group_name  = var.rg_name
  account_tier = var.storage_account_tier
  account_replication_type = var.storage_replication_tier
  allow_nested_items_to_be_public = false
  min_tls_version = "TLS1_2"

  network_rules {
    default_action = "Deny"
    bypass = ["AzureServices"]
    virtual_network_subnet_ids = [var.subnet_id]
    ip_rules = ["111.93.123.196"]
  }
}

resource "azurerm_storage_container" "test_container" {
  name                  = "test-container"
  storage_account_name  = azurerm_storage_account.test_storage_account.name
  container_access_type = "private"
  depends_on = [azurerm_storage_account.test_storage_account]
}

resource "azurerm_storage_blob" "test_blob" {
  name                   = "test-blob"
  storage_account_name   = azurerm_storage_account.test_storage_account.name
  storage_container_name = azurerm_storage_container.test_container.name
  type                   = "Block"
  source                 = var.sample_file_path
  depends_on = [azurerm_storage_account.test_storage_account]
}

resource "azurerm_storage_share" "file_share" {
  name = "labfileshare"
  storage_account_name = azurerm_storage_account.test_storage_account.name
  quota = 50
  depends_on = [azurerm_storage_account.test_storage_account]
}

output "storage_account_name" {
  value = azurerm_storage_account.test_storage_account.name
}

output "storage_account_key" {
  value = azurerm_storage_account.test_storage_account.primary_access_key
  sensitive = true
}

output "file_share_name" {
  value = azurerm_storage_share.file_share.name
}
