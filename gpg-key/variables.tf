variable "gpg_name" {
    type        = string
    description = "The name to be associated with the GPG key."
    default     = "IBMer"
}

variable "gpg_email" {
    type        = string
    description = "The email address associated with the GPG key."
    default      = "ibmer@ibm.com"
}
