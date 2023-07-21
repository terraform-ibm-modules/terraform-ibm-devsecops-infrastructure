##############################################################################
# Outputs
##############################################################################

output "cos_instance_id" {
  value       = ibm_resource_instance.cos_instance.id
  description = "The instance Id of the COS instance."
}
