variable "secrets_manager_guid" {
  type        = string
  description = "The ID of an existing Secrets Manager instance."
  default     = ""
}

variable "secret_group_id" {
  type        = string
  description = "The ID of an existing Secrets Manager secret group."
  default     = ""
}

variable "secret_name" {
  type        = string
  description = "The name of the secret to be created."
  default     = ""
}

variable "secret_description" {
  type        = string
  description = "Optional description for the secret."
  default     = ""
}

variable "secret_labels" {
  type        = list(string)
  description = "Label for the specified secret."
  default     = []
}

variable "expiration_date" {
  type        = string
  description = "Set an optional date for the secret to expired. The date format follows RFC 3339."
  default     = ""
}

variable "secret_payload_password" {
  type        = string
  description = "The secret data that is added during the secret creation."
  default     = ""
  sensitive   = true
}

variable "region" {
  type        = string
  description = "The Secrets Manager location"
  default     = ""
}
