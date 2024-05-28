variable "kp_name" {
  type        = string
  description = "The name of the Key Protect instance. "
  default     = ""
}

variable "kp_location" {
  type        = string
  description = "The region location of the Key Protect instance. "
  default     = ""
}

variable "resource_group_id" {
  type        = string
  description = "The ID of the resource group."
  default     = ""
}
