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
  type = list(string)
  default = [ "vm-snet" ]
}

variable "subnet_prefixes" {
  description = "Sets the adress prefixes for each of the subnets defined by var.subnet_names"
  type = list(string)
  default = [ "10.0.1.0/24" ]
}

variable "admin_password" {
  type = string
}