locals {
  create_secret_group = (var.sm_secret_group_id == "") ? false : true
}

resource "ibm_sm_secret_group" "sm_secret_group" {
  count       = (local.create_secret_group) ? 0 : 1
  instance_id = var.sm_instance_id
  region      = var.sm_location
  name        = var.sm_secret_group
}

data "ibm_sm_secret_group" "secret_group" {
  count           = (local.create_secret_group) ? 1 : 0
  instance_id     = var.sm_instance_id
  region          = var.sm_location
  secret_group_id = var.sm_secret_group_id
}
