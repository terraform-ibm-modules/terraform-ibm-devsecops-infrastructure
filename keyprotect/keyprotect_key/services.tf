resource "ibm_kms_key" "kp_key" {
  instance_id  = var.keyprotect_guid
  key_name     = var.secret_name
  standard_key = var.is_standard_key
  force_delete = var.enable_force_delete
  payload      = base64encode(var.secret_payload_password)
}

#resource "ibm_kms_key_policies" "key_policy" {
#  depends_on  = [ibm_kms_key.kp_key]
#  instance_id = var.keyprotect_guid
#  key_id      = ibm_kms_key.kp_key.key_id
#  rotation {
#    interval_month = 3
#  }
#  dual_auth_delete {
#    enabled = false
#  }
#}
