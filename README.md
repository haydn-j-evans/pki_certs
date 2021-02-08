# Windows PKI Certificate Issuing

Ansible role that generates an openssl config, creates an csr request, and automatically requests/retrieves a certiicate from a Microsoft CA Server


## Usage

This role can be used with the followung variables:

```yaml
---
- hosts: lall
  tasks:
    - name: Include role
      include_role:
        name: haydn-j-evans/pki_certs
      vars:
        ansible_host: 
        ansible_domain:
        pki_ca_host:
        update_existing_cert_domains: true/false
        certificate_organisational_unit: 
        certificate_organisation:
        certificate_email:
        certificate_cn:
        certificate_country:
        certificate_state:
        certificate_city:
        pki_san1: 
        .
        pki_san20: 
        pki_ip1:
        .
        pki_ip5:

```

The role supports a max of 20 Subject Alternative Names and a max of 5 IP addresses. Only insert as many values as you need.

## Renewing Certificates vs Issuing certificates with new domains included.

If you wish to only update a certificate that is due to expire, use the value "update_existing_cert_domains: false" This will then search for an existing openssl.conf at the following location:

/etc/pki/tls/misc/openssl.conf

If this file is not present, the role will end.

## Certificate and Key locations

The role will place the certificate and key in the following locations:

Certificate - /etc/pki/tls/certs/{ ansible_hostname.ansible_domain }.cert

Key - /etc/pki/tls/private/{ ansible_hostname.ansible_domain }.key

## Tags

The role supports the following tags for more granularity:

pfx - If java is present on the system, this tag will generate a PFX file from the generated certificate

cert - Performs the steps to generate the certificate

verify - copies the certificate + key from the temporary directory to the final location =

validate - compares the generated certificate and generated key hashes to ensure a valid cert is generated.
