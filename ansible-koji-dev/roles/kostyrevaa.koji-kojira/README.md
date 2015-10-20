Role Name
=========

 This role installs and configures the kojira.

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

* `koji_kojira_user`: Same as in cert's CN. Default is kojira.

* `koji_kojira_hub_server`: This is the url of koji hub. Default uses var from koji-builder.

* `koji_kojira_topdir`: This is topdir of the koji. Default is /mnt/koji.

* `koji_builder_topurl`: This is the url of kojifiles. Default uses hostvars discover.

* `koji_kojira_cert`: This is the client certificate of kojira user. Default is /etc/pki/koji/pems/kojira.pem.

* `koji_kojira_ca`: This is the certificate of the CA that issued the client certificate. Default is /etc/pki/koji/koji_ca_cert.crt.

* `koji_kojira_serverca`: This is the certificate of the CA that issued the HTTP server certificate. Default is /etc/pki/koji/koji_ca_cert.crt.

* `koji_kojira_grant_repo`: Should this role attempt to execute shell command that grants kojira repo permission. If this is a all-in-one setup put true. Default is false.

* `koji_kojira_issue_cert`: Should this role attempt to issue cert for kojira. If this is a all-in-one setup set it to true. Default is false.


Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: koji_builder
      roles:
         - kostyrevaa.koji-builder
         - kostyrevaa.koji-kojira

License
-------

GPLv3

Author Information
------------------

 Send your suggestions and pull requests to https://github.com/kostyrevaa/ansible-koji-kojira.

 When send PR make sure your changes are backward-compatible.

 Test your changes to role with https://github.com/kostyrevaa/ansible-koji-infra
