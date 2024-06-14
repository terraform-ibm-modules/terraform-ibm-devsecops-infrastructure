#!/bin/bash

dnf install pinentry -y
dnf install expect -y

function parse_input() {
  eval "$(jq -r '@sh "export EMAIL=\(.email) NAME=\(.name)"')"
  if [[ -z "${EMAIL}" ]]; then export EMAIL=none; fi
  if [[ -z "${NAME}" ]]; then export NAME=none; fi
}

export EMAIL="huayuenh@ie.ibm.com"
export NAME="hyhyh"
function createKey {
    /usr/bin/expect << END 
        set timeout -1
        spawn bash
        send "gpg --pinentry-mode loopback --passphrase='' --generate-key\r"
        expect "Real name: "
        send -- "$NAME\n"
        expect "Email address: "
        send -- "$EMAIL\n"
        expect "Change (N)ame, (E)mail, or (O)kay/(Q)uit? "
        send -- "o\r"
        expect EOF
        close -i $SSH_PID
END
}

function generate_keys() {
  KEY_LIST=$(gpg --list-secret-keys)

  if [[ "${KEY_LIST}" != *"${EMAIL}"* ]]; then
    createKey
  fi

  sleep 10

  #Export the signing key
  SIGNING_KEY=$(gpg --export-secret-key "${EMAIL}" | base64 -w0)
  #SIGNING_KEY=$( echo -n "${SIGNING_KEY}" | tr '\n' '@' | sed -E 's/@//g' )
  #Export the public signing certifacate
  PUBLIC_CERTIFICATE=$(gpg --armor --export "${EMAIL}" | base64 -w0)
  #PUBLIC_CERTIFICATE=$( echo -n "${PUBLIC_CERTIFICATE}" | tr '\n' '@' | sed -E 's/@//g' )

  #Terraform requires a JSON response from a script
  JSON_STRING_RESULT=$( jq -n --arg signing_key "$SIGNING_KEY" --arg public_key "$PUBLIC_CERTIFICATE" '{signingkey: $signing_key, publickey: $public_key}' )
  #clean up
  #rm -rf "${FILE}"
  #return response
  echo "${JSON_STRING_RESULT}"
}

parse_input
generate_keys
