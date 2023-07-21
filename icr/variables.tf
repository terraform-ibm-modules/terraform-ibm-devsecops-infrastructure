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
