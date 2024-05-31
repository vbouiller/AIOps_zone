#Environement variables for Azure
data "environment_variable" "azure_tenant_id" {
  name = "ARM_TENANT_ID"
}

data "environment_variable" "azure_client_id" {
  name = "ARM_CLIENT_ID"
}

data "environment_sensitive_variable" "azure_client_secret" {
  name = "ARM_CLIENT_SECRET"
}

#Environement variables for Datadog
data "environment_sensitive_variable" "dd_apikey" {
  name = "DD_API_KEY"
}

# AIOps_Platform HCP outputs

data "tfe_outputs" "aiops_platform_vault" {
  organization = "TFC-Unification-Test-Org-2"
  workspace    = "AIOps_platform"
}