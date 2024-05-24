##############################################################################
# Outputs
##############################################################################

output "gpg_key" {
    description = "The GPG signing key in base64 encoding."
    value = data.external.generate_gpg_secrets.result.signingkey
}

output "gpg_public_certificate" {
    description = "The GPG public certificate in base64 encoding."
    value = data.external.generate_gpg_secrets.result.publickey
}