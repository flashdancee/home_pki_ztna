# NVision private-PKI integration

NVision serves the authenticated UI on port 8971. The host certificate directory is mounted read-only at `/etc/letsencrypt/live/frigate`, following Frigate's certificate layout. It contains `privkey.pem` and `fullchain.pem`.

The private key is generated on the NVision host. Smallstep's default 24-hour leaf certificate is renewed by a companion container using certificate-based authentication. After renewal, `renew-fullchain.sh` atomically combines the leaf and intermediate certificates. NVision checks the certificate fingerprint and reloads its internal NGINX process.

The renewal container uses the same pinned Smallstep image as the CA. It requires write access only to the certificate directory and does not receive the CA provisioner password or either CA private key.

A forced-renewal test changed the leaf fingerprint, rebuilt the chain, and was picked up automatically by NVision without a container restart. Negative tests confirmed that clients without the root and clients using the wrong hostname reject the certificate. The authenticated API continues to reject unauthenticated requests.

The deployed Compose file has a rollback copy named `docker-compose.yaml.before-pki-20260916` beside it. Removing the certificate mount and renewal service restores NVision's generated self-signed certificate after recreation.
