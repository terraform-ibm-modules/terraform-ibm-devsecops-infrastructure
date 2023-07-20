

resource "ibm_resource_instance" "secrets_manager_instance" {
  name              = var.sm_name
  service           = "secrets-manager"
  service_endpoints = var.service_endpoints
  plan              = var.service_plan
  location          = var.sm_location
  resource_group_id = var.resource_group_id
  #parameters = {
  #  "allowed_network" = var.allowed_network
  #}

  timeouts {
    create = "30m"
  }
}
