#!/bin/sh
set -eu

while true; do
	if step ca renew /certs/radius.crt /certs/radius.key \
		--ca-url https://10.0.0.8:9000 \
		--root /certs/root_ca.crt \
		--force; then
		cat /certs/radius.crt /certs/intermediate_ca.crt > /certs/radius-fullchain.crt.new
		chmod 0644 /certs/radius-fullchain.crt.new
		mv /certs/radius-fullchain.crt.new /certs/radius-fullchain.crt
		kill -HUP 1
	fi
	sleep 28800
done
