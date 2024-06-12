resource "random_string" "resource_suffix" {
  count   = (var.add_cos_bucket_name_suffix) ? 1 : 0
  length  = var.random_string_length
  special = false
  upper   = false
}

resource "ibm_cos_bucket" "smart" {
  count                = ((var.existing_bucket_name == "") && (var.enable_retention == true)) ? 1 : 0
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
  count                = ((var.existing_bucket_name == "") && (var.enable_retention == false)) ? 0 : 1
  bucket_name          = (var.add_cos_bucket_name_suffix) ? format("%s-%s", var.bucket_name, random_string.resource_suffix[0].result) : var.bucket_name
  resource_instance_id = var.cos_instance_id
  region_location      = var.bucket_region
  storage_class        = var.storage_class
}

data "ibm_cos_bucket" "cos_bucket_data" {
  count                = (var.existing_bucket_name != "") ? 1 : 0
  bucket_name          = var.existing_bucket_name
  resource_instance_id = var.cos_instance_id
  bucket_type          = var.bucket_type
  bucket_region        = var.bucket_region
}
