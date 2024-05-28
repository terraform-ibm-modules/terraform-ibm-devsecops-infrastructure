variable "sm_name" {
  type        = string
  description = "The name of the Secrets Manager instance."
  default     = ""
}

variable "service_endpoints" {
  type        = string
  description = "The service endpoints for Secrets Manager."
  default     = ""
}

variable "service_plan" {
  type        = string
  description = ""
  default     = ""
}

variable "sm_location" {
  type        = string
  description = "The Secrets Manager location"
  default     = ""
}

variable "resource_group_id" {
  type        = string
  description = "The resource group ID containing the Secrets Manager instance."
  default     = ""
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group containing the Secrets Manager instance."
  default     = ""
}

variable "sm_instance_id" {
  type        = string
  description = "The ID of an existing Secrets Manager instance."
  default     = ""
}
