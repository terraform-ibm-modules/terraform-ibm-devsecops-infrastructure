variable "secrets_manager_guid" {
}

variable "secret_group_id" {
}

variable "secret_name" {
}

variable "secret_description" {
}

variable "secret_labels" {
  type        = list(string)
  description = "Label for the specified secret."
  default     = []
}

variable "expiration_date" {
}

variable "secret_payload_password" {
}

variable "region" {
}
