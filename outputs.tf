##############################################################################
# Outputs
##############################################################################

#############################################################################
locals {
  sm_resource_group_name = try(module.sm[0].sm_resource_group_name, "")
}

output "cluster_name" {
  value       = try(module.vpc_cluster[0].cluster_name, "")
  description = "The name of the VPC cluster."
}

output "cos_s3_endpoint_public" {
  value       = try(module.cos_bucket[0].s3_endpoint_public, "")
  description = "The COS bucket public endpoint."
}

output "cos_s3_endpoint_private" {
  value       = try(module.cos_bucket[0].s3_endpoint_private, "")
  description = "The COS bucket private endpoint."
}

output "cos_s3_endpoint_direct" {
  value       = try(module.cos_bucket[0].s3_endpoint_direct, "")
  description = "The COS bucket direct endpoint."
}

output "cos_bucket_name" {
  value       = try(module.cos_bucket[0].bucket_name, "")
  description = "The name of COS bucket."
}

output "cos_instance_id" {
  value       = try(module.cos[0].cos_instance_id, "")
  description = "The instance Id of the COS instance."
}

output "icr_namespace" {
  value       = try(module.icr[0].icr_namespace, "")
  description = "The ICR namespace."
}

output "resource_group_name" {
  value       = try(module.resource_group.resource_group_name, "")
  description = "The name of the resource group."
}

output "resource_group_id" {
  value       = try(module.resource_group.resource_group_id, "")
  description = "The Id of the resource group."
}

output "secrets_manager_instance_id" {
  value       = try(module.sm[0].instance_id, "")
  description = "The instance Id of the Secrets Manager instance."
}

output "secrets_manager_name" {
  value       = var.sm_name
  description = "The Secrets Manager name."
}

output "secrets_manager_location" {
  value       = try(module.sm[0].sm_location, "")
  description = "The region containing the Secrets Manager instance."
}

output "secrets_manager_resource_group_name" {
  value       = (local.sm_resource_group_name == "") ? module.resource_group.resource_group_name : local.sm_resource_group_name
  description = "The name of the resource group containing the Secrets Manager instance."
}

output "secrets_manager_secrets_group" {
  value       = try(module.sm_secret_group[0].secret_group_name, "")
  description = "The secret group containing the `ibmcloud-api-key` for running the pipelines."
}

output "keyprotect_instance_id" {
  value       = try(module.kp[0].instance_id, "")
  description = "The instance Id of the Key Protect instance."
}
