
locals {
  use_free = (var.machine_type == "free") ? true : false
}

resource "ibm_container_cluster" "free_cluster" {
  count             = (local.use_free) ? 1 : 0
  name              = var.cluster_name
  datacenter        = var.data_center
  resource_group_id = var.resource_group_id
  machine_type      = var.machine_type
  hardware          = var.hardware_type
  default_pool_size = var.default_pool_size
}

resource "ibm_container_cluster" "cluster" {
  count             = (local.use_free) ? 0 : 1
  name              = var.cluster_name
  datacenter        = var.data_center
  resource_group_id = var.resource_group_id
  machine_type      = var.machine_type
  hardware          = var.hardware_type
  public_vlan_id    = var.public_vlan_id
  private_vlan_id   = var.private_vlan_id
  default_pool_size = var.default_pool_size
}
