##############################################################################
# Outputs
##############################################################################

#############################################################################

output "cluster_name" {
  value       = try(module.vpc_cluster.cluster_name, "")
  description = "The name of the VPC cluster."
}

output "cos_s3_endpoint_public" {
  value       = try(module.cos.s3_endpoint_public, "")
  description = "The COS bucket public endpoint."
}

output "cos_s3_endpoint_private" {
  value       = try(module.cos.s3_endpoint_private, "")
  description = "The COS bucket private endpoint."
}

output "cos_s3_endpoint_direct" {
  value       = try(module.cos.s3_endpoint_direct, "")
  description = "The COS bucket direct endpoint."
}

output "cos_bucket_name" {
  value       = try(module.cos.bucket_name, "")
  description = "The name of COS bucket."
}

output "icr_namespace" {
  value       = try(module.icr.icr_namespace, "")
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
  value       = try(module.sm.instance_id, "")
  description = "The instance Id of the Secrets Manager instance."
}
