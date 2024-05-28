variable "registry_namespace" {
  type        = string
  description = "A unique namespace within the IBM Cloud Container Registry region where the application image is stored."
  default     = ""
}

variable "resource_group_id" {
  type        = string
  description = "The resource group containing the registry region namespace."
  default     = ""
}

variable "add_icr_name_suffix" {
  type        = bool
  description = "Set to `true` to append a random 4 character string to the name of the value of the provided COS bucket name."
  default     = false
}
