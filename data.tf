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

# AIOps_Platform HCP outputs

data "tfe_outputs" "aiops_platform_vault" {
  organization = "TFC-Unification-Test-Org-2"
  workspace    = "AIOps_platform"
}