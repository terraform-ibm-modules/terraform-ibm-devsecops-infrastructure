resource "ibm_resource_instance" "cd_instance" {
  name              = var.instance_name
  service           = "continuous-delivery"
  plan              = var.service_plan
  location          = var.instance_region
  resource_group_id = var.resource_group_id
}
