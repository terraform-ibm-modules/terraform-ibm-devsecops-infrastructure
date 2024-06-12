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
      echo "Key-Length: 2048"
      echo "Subkey-Type: RSA"
      echo "Subkey-Length: 2048"
      echo "Name-Real: ${NAME}"
      echo "Name-Email: ${EMAIL}"
      echo "%no-ask-passphrase"
      echo "%no-protection"
      echo "%commit"
      echo "%echo done"
    } >> "${FILE}"

    #Generate a GPG key
    gpg --batch --gen-key "${FILE}"
    #Export the signing key
    SIGNING_KEY=$(gpg --export-secret-key --export-options export-minimal "${EMAIL}" | base64)
    SIGNING_KEY=$( echo -n "${SIGNING_KEY}" | tr '\n' '@' | sed -E 's/@//g' )
    #Export the public signing certifacate
    PUBLIC_CERTIFICATE=$(gpg --armor --export "${EMAIL}" | base64)
    PUBLIC_CERTIFICATE=$( echo -n "${PUBLIC_CERTIFICATE}" | tr '\n' '@' | sed -E 's/@//g' )

    #Terraform requires a JSON response from a script
    JSON_STRING_RESULT=$( jq -n --arg signing_key "$SIGNING_KEY" --arg public_key "$PUBLIC_CERTIFICATE" '{signingkey: $signing_key, publickey: $public_key}' )
    #clean up
    rm -rf "${FILE}"
    #return response
    echo "${JSON_STRING_RESULT}"
 }

parse_input
generate_keys
