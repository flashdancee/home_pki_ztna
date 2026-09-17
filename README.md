# Homelab ZTNA and PKI

A phased, free-software lab for learning certificate management, identity, and service-specific access control on Proxmox.

Start with [PLAN.md](PLAN.md). The first deliverable is one Frigate endpoint with a certificate issued by a private lab CA, trusted by one test client. Later phases add renewal, reverse-proxy integration, SSO/MFA, and ZTNA.

Status: planning and read-only discovery completed on 2026-09-16. No VM, CA, DNS, proxy, or application configuration has been changed.

New infrastructure belongs on a dedicated VM, not an existing Docker host. Existing Frigate and proxy deployments receive only the configuration needed for their selected pilot phase.

Keep credentials, CA state, private keys, backups, and raw infrastructure exports out of Git. Use placeholders in published examples. Proposed resume statements are learning targets until their acceptance tests have passed.
