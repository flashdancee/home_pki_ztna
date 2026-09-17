# Trust the lab CA in Firefox

Status: complete. Firefox trusts the imported root and opened the CA health endpoint without a warning. NVision browser validation remains after its newly issued certificate is installed.

We will do this together after issuing the pilot certificate:

1. Use the Git-ignored `local/Home_Lab_Root_CA.crt`. Confirm its SHA-256 fingerprint is `69:28:FD:89:4F:20:5A:A4:3A:F1:09:DE:19:C1:B6:CC:36:8B:75:84:5E:D8:F0:59:87:D7:6C:77:79:3F:97:1F`. Do not import a private key or the NVision leaf certificate as a root authority.
2. Open Firefox Settings and search for **certificates**, then select **View Certificates**. Depending on the Firefox version, this is under Privacy & Security, possibly within Advanced settings.
3. Select **Authorities → Import**, and choose the verified root certificate file.
4. Enable trust for identifying websites when prompted, then confirm.
5. Open the chosen Frigate HTTPS hostname. Inspect the site's certificate: the hostname must match its SAN, the issuer must be the lab CA, and the connection must succeed without a warning or saved security exception.

This trusts the CA in the selected Firefox profile. It does not guarantee that other browsers, command-line tools, or applications on the PC trust it. A CA trusted for websites can authenticate names beyond this single Frigate endpoint, so protect the signing keys accordingly.

If Firefox still reports an error, inspect the exact error, DNS resolution, hostname, certificate chain and validity dates. Do not click through the warning as the acceptance test.

To undo the import, return to **View Certificates → Authorities**, select only the lab CA, and use **Delete or Distrust**. Lab-issued sites should then fail validation unless that CA is also trusted through another configured source.

References: [Mozilla: changing certificate trust](https://wiki.mozilla.org/CA/Changing_Trust_Settings), [Mozilla: third-party roots and current settings layout](https://support.mozilla.org/en-US/kb/automatically-trust-third-party-certificates).
