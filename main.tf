
locals {
  cos_tier = ( 
    (var.cos_service_plan != "") ? var.cos_service_plan :
    (var.use_free_tier) ? "lite" : "standard"
  )

  sm_tier = (
    (var.sm_service_plan != "") ? var.sm_service_plan :
    (var.use_free_tier) ? "trial" : "standard"
  )

  cd_tier = (
    (var.cd_service_plan != "") ? var.cd_service_plan :
    (var.use_free_tier) ? "lite" : "professional"
  )

  use_vpc = (
    (var.use_free_tier) ? false : var.create_cluster
  )
}

module "resource_group" {
  source                  = "./resource_group"
  existing_resource_group = var.existing_resource_group
  resource_group          = var.resource_group
}

module "icr" {
  count                         = (var.create_icr) ? 1 : 0
  source                        = "./icr"
  depends_on                    = [module.resource_group]
  registry_namespace            = var.registry_namespace
  resource_group_id             = (var.icr_resource_group_id == "") ? module.resource_group.resource_group_id : var.icr_resource_group_id
}

module "cos" {
  count              = (var.create_cos) ? 1 : 0
  source             = "./cos"
  depends_on         = [module.resource_group]
  instance_name      = var.cos_instance_name
  service_plan       = local.cos_tier
  instance_region    = (var.cos_instance_region == "") ? var.region : var.cos_instance_region
  storage_class      = var.cos_storage_class
  bucket_region      = (var.cos_bucket_region == "") ? var.region : var.cos_bucket_region
  bucket_name        = var.cos_bucket_name
  default_retention  = var.cos_default_retention
  minimum_retention  = var.cos_minimum_retention
  maximum_retention  = var.cos_maximum_retention
  is_permanant       = var.is_permanant
  resource_group_id  = (var.cos_resource_group_id == "") ? module.resource_group.resource_group_id : var.cos_resource_group_id
}

module "sm" {
  count             = (var.create_sm) ? 1 : 0
  source            = "./secrets_manager/secrets_manager_instance"
  depends_on        = [module.resource_group]
  sm_name           = var.sm_name
  service_endpoints = var.sm_service_endpoints
  service_plan      = local.sm_tier
  sm_location       = (var.sm_location == "") ? var.region : var.sm_location
  resource_group_id = (var.sm_resource_group_id == "") ? module.resource_group.resource_group_id : var.sm_resource_group_id
}

module "cd" {
  count              = (var.create_cd_instance) ? 1 : 0
  source             = "./continuous_delivery"
  instance_name      = var.cd_instance_name
  service_plan       = local.cd_tier
  instance_region    = (var.cd_instance_region == "") ? var.region : var.cd_instance_region
  resource_group_id  = (var.cd_resource_group_id == "") ? module.resource_group.resource_group_id : var.cd_resource_group_id
}

module "vpc_cluster" {
  count             = (local.use_vpc) ? 1 : 0
  source            = "./cluster"
  depends_on        = [module.resource_group]
  vpc_name          = var.vpc_name
  cluster_name      = var.cluster_name
  worker_count      = var.worker_count
  flavor            = var.flavor
  kube_version      = var.kube_version
  vpc_region        = (var.vpc_region == "") ? var.region : var.vpc_region
  resource_group_id = (var.vpc_resource_group_id == "") ? module.resource_group.resource_group_id : var.vpc_resource_group_id
}