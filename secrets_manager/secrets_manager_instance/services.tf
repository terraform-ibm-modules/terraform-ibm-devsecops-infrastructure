

data "ibm_resource_group" "resource_group" {
  count = (var.resource_group_name != "") ? 1 : 0
  name  = var.resource_group_name
}

resource "ibm_resource_instance" "secrets_manager_instance" {
  count             = (var.sm_instance_id == "") ? 1 : 0
  name              = var.sm_name
  service           = "secrets-manager"
  service_endpoints = var.service_endpoints
  plan              = var.service_plan
  location          = var.sm_location
  resource_group_id = (var.resource_group_name == "") ? var.resource_group_id : data.ibm_resource_group.resource_group[0].id
  #parameters = {
  #  "allowed_network" = var.allowed_network
  #}

  timeouts {
    create = "30m"
  }
}
