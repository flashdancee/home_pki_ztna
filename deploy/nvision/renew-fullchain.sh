#!/bin/sh
set -eu

cert_dir=${CERT_DIR:-/home/step}
temporary_chain=$(mktemp "$cert_dir/fullchain.pem.XXXXXX")

cat "$cert_dir/nvision-home-arpa.crt" "$cert_dir/intermediate_ca.crt" > "$temporary_chain"
chmod 0644 "$temporary_chain"
mv "$temporary_chain" "$cert_dir/fullchain.pem"
