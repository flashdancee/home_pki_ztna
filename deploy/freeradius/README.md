# FreeRADIUS EAP-TLS pilot

This deployment provides certificate-based Wi-Fi authentication for an Aruba
Instant 8.7.1.6 controller. FreeRADIUS listens on UDP 1812 (authentication) and
1813 (accounting) at `10.0.0.8`.

Add `radius.home.arpa -> 10.0.0.8` to Pi-hole before enrolling clients. The
certificate also contains `10.0.0.8` as an IP SAN, but using and validating the
DNS name is clearer and matches enterprise supplicant profiles.

## Trust flow

1. The client validates the RADIUS server certificate for `radius.home.arpa`.
2. FreeRADIUS validates the client's EAP-TLS certificate against the Home Lab
   Root CA.
3. Aruba relays EAP between the client and FreeRADIUS and applies the resulting
   Access-Accept or Access-Reject.

The private RADIUS shared secret and all private keys exist only on the VM under
`/opt/freeradius`; they are intentionally excluded from Git.

The CA's normal 24-hour leaf lifetime is retained. A renewal sidecar checks every
eight hours, renews with the existing certificate key, rebuilds the served chain,
and signals FreeRADIUS to reload. It contains no CA or provisioner credentials.

## Aruba SSID settings

- Usage: Employee
- Security level: Enterprise
- Key management: WPA2-Enterprise initially
- Authentication server: external RADIUS at `10.0.0.8`
- Authentication port: `1812`
- Accounting port: `1813`
- Shared secret: retrieve it directly from the VM as described below
- EAP Offload/termination: disabled
- Reauthentication: leave at the Aruba default for the pilot

Do not remove or modify the existing SSID. Create a separate pilot SSID such as
`Lab-Cert`.

Retrieve the secret without saving it in this repository:

```bash
ssh -F /dev/null admin@10.0.0.8 \
  'sudo sed -n "s/^[[:space:]]*secret = //p" /opt/freeradius/config/clients.conf'
```

Before production use, replace the temporary `10.0.0.0/24` RADIUS client range
with the exact source IP address or addresses observed from the Aruba cluster.
The shared secret authenticates Aruba to FreeRADIUS; it is not a Wi-Fi password
and is never entered by end users.

## Client certificate policy

Wi-Fi client certificates must be individually issued, include the
`clientAuth` extended key usage, and have unique device identities. No client
certificates are issued as part of the server deployment. The dedicated
`wifi-eap` CA provisioner applies the client-only template in
`deploy/step-ca/templates/wifi-client.tpl`; its pilot default lifetime is 30
days and its maximum is 90 days.

## Deployment validation

Validated on 2026-09-16:

- FreeRADIUS 3.2.10 reported healthy and listened on UDP 1812/1813.
- The server certificate chain verified to the Home Lab Root CA.
- A forced renewal changed the leaf fingerprint and FreeRADIUS reloaded it
  without restarting.
- An unauthorized password-based test received `Access-Reject`.
