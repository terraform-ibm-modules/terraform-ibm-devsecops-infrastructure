##############################################################################
# Outputs
##############################################################################

output "cluster_name" {
  value = (var.kube_version == "") ? ibm_container_vpc_cluster.cluster_default_kube[0].name : ibm_container_vpc_cluster.cluster[0].name
}
