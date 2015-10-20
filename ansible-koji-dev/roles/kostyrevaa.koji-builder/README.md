koji-builder
=========

 This role installs and configures the kojid builder.

 This is one of the koji- roles which configures whole koji stack.

Roles are:

 * koji-db (https://galaxy.ansible.com/list#/roles/4459)
 * koji-ca (https://galaxy.ansible.com/list#/roles/4460)
 * koji-web (https://galaxy.ansible.com/list#/roles/4456)
 * koji-kojira (https://galaxy.ansible.com/list#/roles/4457)
 * koji-builder (https://galaxy.ansible.com/list#/roles/4461)
 * koji-hub (https://galaxy.ansible.com/list#/roles/4462)

For example of all-in-one setup go to https://github.com/kostyrevaa/ansible-koji-infra

Role Variables
--------------

There are some variables in the default/main.yml which can (or needs to) be changed/overriden:

* `koji_builder_user`: Same as you will use with koji add-host. Default is {{ ansible_fqdn }}.

* `koji_builder_hub_server`: This is the url of koji hub. Default uses hostvars discover.

* `koji_builder_workdir`: This is workdir of the builder. Default is /tmp/koji.

* `koji_builder_topurl`: This is the url of kojifiles. Default uses hostvars discover.

* `koji_builder_cert`: This is the client certificate of this builder. Default is /etc/pki/koji/pems/{{ ansible_fqdn }}.pem.

* `koji_builder_ca`: This is the certificate of the CA that issued the client certificate. Default is /etc/pki/koji/koji_ca_cert.crt.

* `koji_builder_serverca`: This is the certificate of the CA that issued the HTTP server certificate. Default is /etc/pki/koji/koji_ca_cert.crt.

* `koji_builder_patch_crearepo`: Weather or not patch createrepo python code. Default is false. See https://bugzilla.redhat.com/show_bug.cgi?id=1091708


Dependencies
------------

koji-kojira

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: koji_builder
      roles:
         - koji-builder
         - koji-kojira

License
-------

GPLv3

Author Information
------------------

 Send your suggestions and pull requests to https://github.com/kostyrevaa/ansible-koji-builder.

 When send PR make sure your changes are backward-compatible.

 Test your changes to role with https://github.com/kostyrevaa/ansible-koji-infra
