resource "vault_kv_secret_v2" "openai" {
  mount               = var.vault_openai_mount
  name                = "openai"
  delete_all_versions = true
  data_json = jsonencode(
    {
      deployment = var.openai_deployment_model_name,
      endpoint   = module.openai.openai_endpoint,
      location   = azurerm_resource_group.rg.location,
      primekey   = module.openai.openai_primary_key
    }
  )
}