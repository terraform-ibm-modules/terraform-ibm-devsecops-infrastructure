output "instance_id" {
  value = try(ibm_resource_instance.secrets_manager_instance[0].guid, var.sm_instance_id)
}

output "sm_name" {
  value = var.sm_name
}

output "sm_location" {
  value = var.sm_location
}
