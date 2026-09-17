# Smallstep CA deployment

This Compose definition runs the online intermediate CA on the dedicated security-lab VM. The image is pinned by digest. Runtime CA data and secrets live at `/opt/step-ca` on the VM and must never be committed.

The VM contains the encrypted intermediate signing key and its runtime password. It must contain the public root certificate, but never the offline root private key or root password.

The CA listens on `https://ca.home.arpa:9000`. Its initial provisioners are a password-protected JWK administrator and ACME. Restrict network access to intended management and enrollment clients before expanding beyond the pilot.

Start or update from this directory on the VM:

```sh
sudo docker compose up -d
```

Validate the service using the independently verified public root certificate:

```sh
curl --cacert root_ca.crt https://ca.home.arpa:9000/health
```

Do not use `curl -k` as a successful trust test.
