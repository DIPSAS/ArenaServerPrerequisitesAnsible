arena-server-prerequisites-ansible
===

This repo contains `ansible` playbook for DIPS Arena Server prerequisites.

The target Windows VM's must be [prepared for ansible](https://docs.ansible.com/ansible/latest/user_guide/windows.html).

Requires configuration in `group_vars/appservers.yaml`:

```
ansible_user: ansibleadmin
ansible_password: # local user password for Windows VM.

NuGetServer: # HTTP address to local NuGet server if offline Chocolatey feeds are used.
fileRepository: # HTTP share where Oracle Driver install-files are located.

solr_certificate_name: # Name of the Solr client certificate (.pfx) format.
solr_ssl_key: # Solr client certificate password.
solr_ssl_thumbprint: # Solr certificate thumbprint.
```

The Solr client certificate must be added to `roles/SolrCert/files` in `.pfx` format.

The `Oracle12CDriver` role expects the file `winnt_12102_client32.zip` to be present at a HTTP fileshare, hence the `fileRepository` variable.
