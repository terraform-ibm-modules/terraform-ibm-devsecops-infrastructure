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
    echo "%echo Generating GPG key" >> "${FILE}"
    echo "Key-Type: RSA" >> "${FILE}"
    echo "Key-Length: 2048" >> "${FILE}"
    echo "Subkey-Type: RSA" >> "${FILE}"
    echo "Subkey-Length: 2048" >> "${FILE}"
    echo "Name-Real: ${NAME}" >> "${FILE}"
    echo "Name-Email: ${EMAIL}">> "${FILE}"
    echo "%no-ask-passphrase" >> "${FILE}"
    echo "%no-protection" >> "${FILE}"
    echo "%commit" >> "${FILE}"
    echo "%echo done" >> "${FILE}"
    gpg --batch --gen-key "${FILE}"

    #Generate a GPG key
    gpg --batch --gen-key "${FILE}"
    #Export the signing key
    SIGNING_KEY=$(gpg --export-secret-key "${EMAIL}" | base64)
    #Export the public signing certifacate
    PUBLIC_CERTIFICATE=$(gpg --armor --export "${EMAIL}" | base64)

    #Terraform requires a JSON response from a script
    JSON_STRING_RESULT=$( jq -n --arg signing_key "$SIGNING_KEY" --arg public_key "$PUBLIC_CERTIFICATE" '{signingkey: $signing_key, publickey: $public_key}' )
    #clean up
    rm -rf "${FILE}"
    #return response
    echo "${JSON_STRING_RESULT}"
 }

parse_input
generate_keys