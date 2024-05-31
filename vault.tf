resource "vault_mount" "kvv2" {
  path        = "kv"
  type        = "kv"
  options     = { version = "2" }
  description = "KVv2 for openai information"
}

resource "vault_kv_secret_v2" "openai" {
  mount               = vault_mount.kvv2.path
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

resource "vault_token" "agent" {
  policies     = ["agent"]
  ttl          = "10m"
  renewable    = true
  display_name = "Vault agent token"
}

resource "vault_kv_secret_v2" "agent" {
  mount               = vault_mount.kvv2.path
  name                = "agent"
  delete_all_versions = true
  data_json = jsonencode(
    {
      token = vault_token.agent.client_token
    }
  )
}

resource "vault_kv_secret_v2" "dd" {
  mount               = vault_mount.kvv2.path
  name                = "dd"
  delete_all_versions = true
  data_json = jsonencode(
    {
      apikey = data.environment_sensitive_variable.dd_apikey.value
    }
  )
}