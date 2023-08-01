resource "ibm_kms_key" "kp_key" {
  instance_id  = var.keyprotect_guid
  key_name     = var.secret_name
  standard_key = var.is_standard_key
  force_delete = var.enable_force_delete
  payload      = base64encode(var.secret_payload_password)
}


