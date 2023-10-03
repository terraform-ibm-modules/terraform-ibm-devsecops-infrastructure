variable "worker_count" {
  default = 1
}

variable "flavor" {
  default = "bx2.2x8"
}

variable "kube_version" {
}

variable "vpc_region" {}

variable "vpc_name" {}

variable "cluster_name" {}

variable "resource_group_id" {}

variable "createPublicGateway" {
  default = false
}

variable "wait_till" {
}
