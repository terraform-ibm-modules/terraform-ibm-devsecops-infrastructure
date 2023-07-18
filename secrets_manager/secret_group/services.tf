resource "ibm_sm_secret_group" "sm_secret_group" {
  instance_id = var.sm_instance_id
  region      = var.sm_location
  name        = var.sm_secret_group
}