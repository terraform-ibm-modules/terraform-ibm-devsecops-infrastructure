resource "random_string" "resource_suffix" {
  count   = (var.add_cos_bucket_name_suffix) ? 1 : 0
  length  = 4
  special = false
  upper   = false
}

resource "ibm_cos_bucket" "smart" {
  count                = (var.enable_retention) ? 1 : 0
  bucket_name          = (var.add_cos_bucket_name_suffix) ? format("%s-%s", var.bucket_name, random_string.resource_suffix[0].result) : var.bucket_name
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
  count                = (var.enable_retention) ? 0 : 1
  bucket_name          = (var.add_cos_bucket_name_suffix) ? format("%s-%s", var.bucket_name, random_string.resource_suffix[0].result) : var.bucket_name
  resource_instance_id = var.cos_instance_id
  region_location      = var.bucket_region
  storage_class        = var.storage_class
}
