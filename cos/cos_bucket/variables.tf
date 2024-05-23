variable "service_plan" {
}

variable "storage_class" {
}

variable "bucket_region" {
}

variable "bucket_name" {
}

variable "default_retention" {
}

variable "minimum_retention" {
}

variable "maximum_retention" {
}

variable "is_permanant" {
}

variable "cos_instance_id" {
}

variable "add_cos_bucket_name_suffix" {
    type        = bool
    description = "Set to `true` to appen a random 4 character string to the name of the value of the provided COS bucket name."
    default     = false
}
