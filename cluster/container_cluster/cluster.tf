resource "ibm_container_cluster" "cluster" {
  name              = var.cluster_name
  datacenter        = var.data_center
  resource_group_id = var.resource_group_id
  machine_type      = var.machine_type
  hardware          = var.hardware_type
  wait_till         = var.wait_till
  public_vlan_id    = var.public_vlan_id
  private_vlan_id   = var.private_vlan_id
  default_pool_size = var.default_pool_size
}
