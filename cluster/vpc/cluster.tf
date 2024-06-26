locals {
  ZONE1 = "${var.vpc_region}-1"
}

resource "ibm_is_vpc" "vpc1" {
  name           = var.vpc_name
  resource_group = var.resource_group_id
  #region comes from provider
}

resource "ibm_is_subnet" "subnet1" {
  name                     = "subnet-${var.vpc_name}"
  vpc                      = ibm_is_vpc.vpc1.id
  zone                     = local.ZONE1
  total_ipv4_address_count = 256
  resource_group           = var.resource_group_id
}

resource "ibm_container_vpc_cluster" "cluster" {
  count             = (var.kube_version != "") ? 1 : 0
  name              = var.cluster_name
  vpc_id            = ibm_is_vpc.vpc1.id
  kube_version      = var.kube_version
  flavor            = var.flavor
  wait_till         = var.wait_till
  worker_count      = var.worker_count
  resource_group_id = var.resource_group_id

  zones {
    subnet_id = ibm_is_subnet.subnet1.id
    name      = local.ZONE1
  }
}

resource "ibm_container_vpc_cluster" "cluster_default_kube" {
  count             = (var.kube_version == "") ? 1 : 0
  name              = var.cluster_name
  vpc_id            = ibm_is_vpc.vpc1.id
  flavor            = var.flavor
  wait_till         = var.wait_till
  worker_count      = var.worker_count
  resource_group_id = var.resource_group_id

  zones {
    subnet_id = ibm_is_subnet.subnet1.id
    name      = local.ZONE1
  }
}

resource "ibm_is_public_gateway" "public_gateway" {
  count          = (var.createPublicGateway) ? 1 : 0
  name           = "public-gateway-${var.vpc_name}"
  vpc            = ibm_is_vpc.vpc1.id
  zone           = local.ZONE1
  resource_group = var.resource_group_id
}

data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = (var.kube_version == "") ? ibm_container_vpc_cluster.cluster_default_kube[0].id : ibm_container_vpc_cluster.cluster[0].id
}
