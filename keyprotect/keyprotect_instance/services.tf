resource "ibm_resource_instance" "keyprotect_instance" {
  name              = var.kp_name
  service           = "kms"
  plan              = "tiered-pricing"
  location          = var.kp_location
  resource_group_id = var.resource_group_id
}