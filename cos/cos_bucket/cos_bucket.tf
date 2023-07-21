
locals {
  use_lite = (var.service_plan == "lite") ? true : false
}

resource "ibm_cos_bucket" "smart" {
  count                = (local.use_lite) ? 0 : 1
  bucket_name          = var.bucket_name
  resource_instance_id = var.cos_instance_id
  region_location      = var.bucket_region
  storage_class        = var.storage_class
  #hard_quota           = 1024
  #force_delete        = true
  retention_rule {
    default   = var.default_retention
    maximum   = var.maximum_retention
    minimum   = var.minimum_retention
    permanent = var.is_permanant
  }
}

resource "ibm_cos_bucket" "smart_lite" {
  count                = (local.use_lite) ? 1 : 0
  bucket_name          = var.bucket_name
  resource_instance_id = var.cos_instance_id
  region_location      = var.bucket_region
  storage_class        = var.storage_class
}