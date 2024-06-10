variable "keyprotect_guid" {
  type        = string
  description = "The Key Protect instance ID (GUID)."
  default     = ""
}

variable "secret_name" {
  type        = string
  description = "The name of the created secret."
  default     = ""
}

variable "is_standard_key" {
  type        = bool
  description = "Set to `true` for a standard key or `false` for a `root` key."
  default     = false
}

variable "enable_force_delete" {
  type        = bool
  description = "If set to true, Key Protect forces the deletion of a root or standard key, even if this key is still in use, such as to protect an IBM Cloud Object Storage bucket. Note, the key cannot be deleted if the protected cloud resource is set up with a retention policy. Successful deletion includes the removal of any registrations that are associated with the key"
  default     = false

}

variable "secret_payload_password" {
  type        = string
  description = "The secret to be stored."
  default     = ""
  sensitive   = true
}
