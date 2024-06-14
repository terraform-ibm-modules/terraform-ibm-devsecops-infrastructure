#!/bin/bash

dnf install pinentry -y
dnf install expect -y

function parse_input() {
  eval "$(jq -r '@sh "export EMAIL=\(.email) NAME=\(.name)"')"
  if [[ -z "${EMAIL}" ]]; then export EMAIL=none; fi
  if [[ -z "${NAME}" ]]; then export NAME=none; fi
}

SIGNING_KEY="placeholder"
PUBLIC_CERTIFICATE="placeholder"
function createKey {
    /usr/bin/expect << END 
        set timeout -1
        spawn bash -c "gpg --pinentry-mode loopback --passphrase='' --generate-key"
        expect "Real name: "
        send -- "$NAME\n"
        expect "Email address: "
        send -- "$EMAIL\n"
        expect "Change (N)ame, (E)mail, or (O)kay/(Q)uit? "
        send -- "o\r"
        expect EOF
END
}

function generate_keys() {
  KEY_LIST=$(gpg --list-secret-keys)

  if [[ "${KEY_LIST}" != *"${EMAIL}"* ]]; then
    $(createKey) &
  fi

  #Test the keystore for the signing key creation
  max=10
  for (( i=0; i < $max; ++i ))
  do
    KEY_LIST=$(gpg --list-secret-keys)
    if [[ "${KEY_LIST}" != *"${EMAIL}"* ]]; then
      sleep 10
    else
      #Export the signing key
      SIGNING_KEY=$(gpg --export-secret-key "${EMAIL}" | base64)
      PUBLIC_CERTIFICATE=$(gpg --armor --export "${EMAIL}" | base64)
      i=$max
    fi
  done
  
  #Terraform requires a JSON response from a script
  JSON_STRING_RESULT=$( jq -n --arg signing_key "$SIGNING_KEY" --arg public_key "$PUBLIC_CERTIFICATE" '{signingkey: $signing_key, publickey: $public_key}' )

  #return response
  echo "${JSON_STRING_RESULT}"
}

parse_input
generate_keys