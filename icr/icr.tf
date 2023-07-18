
resource "ibm_cr_namespace" "cr_namespace" {
  name              = var.registry_namespace
  resource_group_id = var.resource_group_id
}
