data "azurerm_key_vault_secret" "ssl_cert" {
  provider     = azurerm.central
  name         = var.ssl_cert_name
  key_vault_id = var.ssl_key_vault_id
}
