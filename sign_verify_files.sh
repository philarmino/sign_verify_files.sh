#!/bin/bash
# Sign a file with a private and public keys using OpenSSL and verify it
# Encode the signature in Base64 format
#
# Usage: sign <file> <private_key>
#        verify <file> <signature> <public_key>
#
# NOTE: to generate a public/private key use the following commands:
#
# openssl genrsa -aes128 -passout pass:<passphrase> -out private.pem 2048
# openssl rsa -in private.pem -passin pass:<passphrase> -pubout -out public.pem
#
# where <passphrase> is the passphrase to be used.

case $1 in
  sign)
    filename=$2
    privatekey=$3

    if [[ $# -lt 3 ]] ; then
      echo "Usage: sign <file> <private_key>"
      exit 1
    fi

    openssl dgst -sha256 -sign $privatekey -out /tmp/$filename.sha256 $filename
    openssl base64 -in /tmp/$filename.sha256 -out signature.sha256
    rm /tmp/$filename.sha256
    ;;

  verify)
    filename=$2
    signature=$3
    publickey=$4

    if [[ $# -lt 4 ]] ; then
      echo "Usage: verify <file> <signature> <public_key>"
      exit 1
    fi

    openssl base64 -d -in $signature -out /tmp/$filename.sha256
    openssl dgst -sha256 -verify $publickey -signature /tmp/$filename.sha256 $filename
    rm /tmp/$filename.sha256
    ;;

  *)
    echo "Usage: $0 sign <file> <private_key>"
    echo "Usage: $0 verify <file> <signature> <public_key>"
esac
