variable "cluster_name" {
  type        = string
  description = "The name of the cluster."
  default     = "mycluster-free"
}

variable "data_center"{
  type        = string
  description = "The name of the datacenter. To list options run the cli `ibmcloud ks zones --provider classic` command."
  default     = "ams03"
}

variable "resource_group_id" {
}

variable "machine_type" {
  type        = string
  description = "The cluster machine type."
  default     = "free"
}

variable "hardware_type" {
  type        = string
  description = "The cluster hardware."
  default     = "shared"
}

variable "default_pool_size" {
  type        = number
  description = "The number of worker nodes that you want to add to the default worker pool."
  default     = 1
}

variable "public_vlan_id" {
  type        = string
  description = "The ID of the public VLAN that you want to use for your worker nodes. You can retrieve the VLAN ID with the `ibmcloud ks vlans --zone <zone>` command."
  default     = ""
}

variable "private_vlan_id" {
  type        = string
  description = "The ID of the private VLAN that you want to use for your worker nodes. You can retrieve the VLAN ID with the `ibmcloud ks vlans --zone <zone>` command."
  default     = ""
}