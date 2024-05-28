variable "instance_name" {
  type        = string
  description = "The name of the COS instance that contains the COS buckets."
  default     = "my-cos-instance"
}

variable "service_plan" {
  type        = string
  description = "The plan type of the Cloud Object Storage instance. Can be `lite`, `standard`, `graduated-tier`"
  default     = ""
}

variable "instance_region" {
  type        = string
  description = "The location of the COS instance."
  default     = "global"
}

variable "resource_group_id" {
  type        = string
  description = "The resource group ID containing the COS instance."
  default     = ""
}
