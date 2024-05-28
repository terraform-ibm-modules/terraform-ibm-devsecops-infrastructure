variable "instance_name" {
  type        = string
  description = "The name of the CD instance service."
  default     = "CD Service"
}

variable "service_plan" {
  type        = string
  description = "The service plan of the CD service. Can be `lite` or `professional`."
  default     = "professional"
}

variable "instance_region" {
  type        = string
  description = "The region containing the CD service instance."
  default     = "us-south"
}

variable "resource_group_id" {
  type        = string
  description = "The resource group ID containing the CD sercive instance."
  default     = ""
}
