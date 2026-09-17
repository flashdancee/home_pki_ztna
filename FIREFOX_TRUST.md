# Trust the lab CA in Firefox

Status: instructions prepared; the CA has not yet been created or imported. The owner selected Firefox on their current PC and requested a guided installation.

We will do this together after issuing the pilot certificate:

1. Obtain the lab CA's **public root certificate** through the administrator connection. Compare its SHA-256 fingerprint with the fingerprint read directly from the CA's trusted setup records. The exact filename and fingerprint will be supplied at deployment time. Do not import a private key or the Frigate leaf certificate as a root authority.
2. Open Firefox Settings and search for **certificates**, then select **View Certificates**. Depending on the Firefox version, this is under Privacy & Security, possibly within Advanced settings.
3. Select **Authorities → Import**, and choose the verified root certificate file.
4. Enable trust for identifying websites when prompted, then confirm.
5. Open the chosen Frigate HTTPS hostname. Inspect the site's certificate: the hostname must match its SAN, the issuer must be the lab CA, and the connection must succeed without a warning or saved security exception.

This trusts the CA in the selected Firefox profile. It does not guarantee that other browsers, command-line tools, or applications on the PC trust it. A CA trusted for websites can authenticate names beyond this single Frigate endpoint, so protect the signing keys accordingly.

If Firefox still reports an error, inspect the exact error, DNS resolution, hostname, certificate chain and validity dates. Do not click through the warning as the acceptance test.

To undo the import, return to **View Certificates → Authorities**, select only the lab CA, and use **Delete or Distrust**. Lab-issued sites should then fail validation unless that CA is also trusted through another configured source.

References: [Mozilla: changing certificate trust](https://wiki.mozilla.org/CA/Changing_Trust_Settings), [Mozilla: third-party roots and current settings layout](https://support.mozilla.org/en-US/kb/automatically-trust-third-party-certificates).
