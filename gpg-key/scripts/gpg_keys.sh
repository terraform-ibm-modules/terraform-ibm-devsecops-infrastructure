#!/bin/bash

function parse_input() {
  eval "$(jq -r '@sh "export EMAIL=\(.email) NAME=\(.name)"')"
  if [[ -z "${EMAIL}" ]]; then export EMAIL=none; fi
  if [[ -z "${NAME}" ]]; then export NAME=none; fi
}

 function generate_keys() {
    FILE="gpg_file.txt"

    #Generate a file to pass into GPG cli
    touch "${FILE}"
    {
      echo "%echo Generating GPG key"
      echo "Key-Type: RSA"
      echo "Key-Length: 3072"
      echo "Subkey-Type: RSA"
      echo "Subkey-Length: 2048"
      echo "Key-Usage: cert, sign"
      echo "Subkey-Usage: encrypt"
      echo "Name-Real: ${NAME}"
      echo "Name-Email: ${EMAIL}"
      echo "Expire-Date: 2y"
      echo "%no-ask-passphrase"
      echo "%no-protection"
      echo "%commit"
      echo "%echo done"
    } >> "${FILE}"

    #Generate a GPG key
    gpg --batch --gen-key "${FILE}"
    #Export the signing key
    SIGNING_KEY=$(gpg --export-secret-key "${EMAIL}" | base64 -w0)
    #Export the public signing certifacate
    PUBLIC_CERTIFICATE=$(gpg --armor --export "${EMAIL}" | base64 -w0)

    #Terraform requires a JSON response from a script
    JSON_STRING_RESULT=$( jq -n --arg signing_key "$SIGNING_KEY" --arg public_key "$PUBLIC_CERTIFICATE" '{signingkey: $signing_key, publickey: $public_key}' )
    #clean up
    rm -rf "${FILE}"
    #return response
    echo "${JSON_STRING_RESULT}"
 }

parse_input
generate_keys