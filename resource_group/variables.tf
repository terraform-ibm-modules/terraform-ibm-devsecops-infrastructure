variable "resource_group" {
  type        = string
  description = "The name of the resource group that will be created."
  default     = ""
}

variable "existing_resource_group" {
  type        = string
  description = "The name of an existing resource group."
  default     = ""
}
