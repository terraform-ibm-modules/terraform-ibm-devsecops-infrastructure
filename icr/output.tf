##############################################################################
# Outputs
##############################################################################

output "icr_namespace" {
  value       = (var.add_icr_name_suffix) ? format("%s-%s", var.registry_namespace, random_string.resource_suffix[0].result) : var.registry_namespace
  description = "The name of container registry namespace."
}
