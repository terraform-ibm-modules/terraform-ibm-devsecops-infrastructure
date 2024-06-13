variable "sm_instance_id" {
  type        = string
  description = "The ID of an existing Secrets Manager instance."
  default     = ""
}

variable "sm_location" {
  type        = string
  description = "The Secrets Manager location"
  default     = ""
}

variable "sm_secret_group_name" {
  type        = string
  description = "The name of the Secrets Manager secret group."
  default     = ""
}

variable "sm_existing_secret_group_id" {
  type        = string
  description = "The ID of an existing Secrets Manager secret group."
  default     = ""
}

variable "sm_endpoint_type" {
  type        = string
  description = "The Endpoint type."
  default     = ""
}
