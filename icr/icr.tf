resource "random_string" "resource_suffix" {
  count   = (var.add_icr_name_suffix) ? 1 : 0
  length  = 8
  special = false
  upper   = false
}

resource "ibm_cr_namespace" "cr_namespace" {
  name              = (var.add_icr_name_suffix) ? format("%s-%s", var.registry_namespace, random_string.resource_suffix[0].result) : var.registry_namespace
  resource_group_id = var.resource_group_id
}
