variable "storage_class" {
  type        = string
  description = "The type of storage."
  default     = "smart"
}

variable "bucket_region" {
  type        = string
  description = "The COS bucket region."
  default     = ""
}

variable "bucket_name" {
  type        = string
  description = "Set the name of your COS bucket."
  default     = ""
}

variable "enable_retention" {
  type        = bool
  description = "Set to `true` to add retention settings."
  default     = true
}

variable "default_retention" {
  type        = string
  description = "The default retention period are defined by this policy and apply to all objects in the bucket."
  default     = ""
}

variable "minimum_retention" {
  type        = string
  description = "Specifies minimum duration of time an object must be kept unmodified in the bucket."
  default     = ""
}

variable "maximum_retention" {
  type        = string
  description = "Specifies maximum duration of time an object that can be kept unmodified in the bucket."
  default     = ""
}

variable "is_permanant" {
  type        = bool
  description = "Specifies a permanent retention status either enable or disable for a bucket."
  default     = false
}

variable "cos_instance_id" {
  type        = string
  description = "The ID of the COS instance to add the bucket."
}

variable "add_cos_bucket_name_suffix" {
  type        = bool
  description = "Set to `true` to append a random 4 character string to the name of the value of the provided COS bucket name."
  default     = false
}

variable "random_string_length" {
  type        = number
  description = "The length of the random suffix added to the resource name."
  default     = 8
}

variable "existing_bucket_name" {
  type        = string
  description = "Set the name of an existing COS bucket."
  default     = ""
}

variable "bucket_type" {
  type        = string
  description = "The type of the bucket. Supported values are `single_site_location`, `region_location`, and `cross_region_location`."
  default     = "region_location"
}
