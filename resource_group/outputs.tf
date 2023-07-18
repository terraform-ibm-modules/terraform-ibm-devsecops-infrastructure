##############################################################################
# Outputs
##############################################################################

output "resource_group_name" {
  value       = (var.existing_resource_group == "") ? ibm_resource_group.resource_group[0].name : data.ibm_resource_group.resource_group[0].name
  description = "Resource group name"
}

output "resource_group_id" {
  value       = (var.existing_resource_group == "") ? ibm_resource_group.resource_group[0].id : data.ibm_resource_group.resource_group[0].id
  description = "Resource group ID"
}
