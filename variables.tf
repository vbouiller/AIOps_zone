variable "tf_hostname" {
  type        = string
  description = "Terraform instance hostname. Defaults to the EU HCP Terraform instance"
  default     = "app.eu.terraform.io"
}

variable "resource_group_location" {
  type    = string
  default = "francecentral"
}

variable "prefix" {
  description = "A prefix for resources names"
  type        = string
  default     = "vb"
}

variable "is_public" {
  description = "Boolean value to set the AI Zone as public or not"
  type        = bool
  default     = false
}

variable "subnet_names" {
  description = "Defines the number and names of subnets"
  type        = list(string)
  default     = ["vm-snet"]
}

variable "subnet_prefixes" {
  description = "Sets the adress prefixes for each of the subnets defined by var.subnet_names"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "pkr_bucket_name" {
  type        = string
  description = "(Required) HCP Packer bucket name from where to pull the image"
}

variable "pkr_channel_name" {
  type        = string
  default     = "production"
  description = "(Optional) HCP Packer channel name from where to pull the image. Default: latest"
}

variable "pkr_platform" {
  type        = string
  description = "(Optional) HCP Packer platform where the image is stored. Default: azure"
  default     = "azure"
}

variable "pkr_region" {
  type        = string
  description = "(Optional) HCP Packer region where the image is stored. Default: francecentral"
  default     = "francecentral"
}

variable "azure_pkey" {
  type        = string
  description = "(Required) Public key needed for Azure VM access"
}

variable "ws_platform_org" {
  type        = string
  description = "(Optional) Name of the organisation where the platform workspace is. Used by tfe_outputs data source. Default: TFC-Unification-Test-Org-2"
  default     = "TFC-Unification-Test-Org-2"
}

variable "ws_platform_name" {
  type        = string
  description = "(Optional) Name of the workspace hosting the platform infra for tfe_outputs data source. Default: AIOps_platform"
  default     = "AIOps_platform"
}

variable "vault_openai_mount" {
  type        = string
  description = "(Optional) Path of the Vault's kvv2 mount point to insert the openai secret. Default: kv"
  default     = "kv"
}

# OpenAI variables

# variable "openai_deployment_name" {
#   type    = string
#   default = "testai"
# }

variable "openai_deployment_model_fmt" {
  type    = string
  default = "OpenAI"
}
variable "openai_deployment_model_name" {
  type    = string
  default = "gpt-4"
}
variable "openai_deployment_model_version" {
  type    = string
  default = "0613"
}
variable "openai_deployment_scale_type" {
  type    = string
  default = "Standard"
}