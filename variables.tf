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
