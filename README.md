# Homelab ZTNA and PKI

A phased, free-software lab for learning certificate management, identity, and service-specific access control on Proxmox.

Read [PKI Architecture and Enterprise Mapping](docs/PKI_ARCHITECTURE.md) for a concise explanation of how the deployment works. [PLAN.md](PLAN.md) contains the phased roadmap, acceptance tests, and future SSO/MFA and ZTNA work.

Status: Phase 1 is operational. A dedicated Smallstep CA issues short-lived certificates to NVision, Firefox trusts the private root, and certificate renewal is automated and tested.

New infrastructure belongs on a dedicated VM, not an existing Docker host. Existing Frigate and proxy deployments receive only the configuration needed for their selected pilot phase.

Keep credentials, CA state, private keys, backups, and raw infrastructure exports out of Git. Use placeholders in published examples. Proposed resume statements are learning targets until their acceptance tests have passed.
