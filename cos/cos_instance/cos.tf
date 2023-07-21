resource "ibm_resource_instance" "cos_instance" {
  name              = var.instance_name
  service           = "cloud-object-storage"
  plan              = var.service_plan
  location          = var.instance_region
  resource_group_id = var.resource_group_id
}