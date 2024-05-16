output "app_public_ip" {
  value = azurerm_linux_virtual_machine.app.public_ip_address
}

output "app_URL" {
  value = "http://${azurerm_linux_virtual_machine.app.public_ip_address}:5000"
}

output "app_username" {
  value = azurerm_linux_virtual_machine.app.admin_username
}

// Open AI Outputs

output "openai_endoint" {
  value = module.openai.openai_endpoint
}

output "openai_privateIP" {
  value = module.openai.private_ip_addresses
}

output "openai_primeK" {
  value     = module.openai.openai_primary_key
  sensitive = true
}

output "openai_secondK" {
  value     = module.openai.openai_secondary_key
  sensitive = true
}

output "pe_dns_zone" {
  value = module.openai.azurerm_private_endpoint.this["pe_endpoint"].private_dns_zone_configs
}