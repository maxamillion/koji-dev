Role Name
=========

 This role installs and configures the database for koji.

 This is one of the koji- roles which configures whole koji stack.

Roles are:

 * [koji-db] (https://galaxy.ansible.com/list#/roles/4459/)
 * [koji-ca] (https://galaxy.ansible.com/list#/roles/4460/)
 * [koji-web] (https://galaxy.ansible.com/list#/roles/4456/)
 * [koji-kojira] (https://galaxy.ansible.com/list#/roles/4457/)
 * [koji-builder] (https://galaxy.ansible.com/list#/roles/4461/)
 * [koji-hub] (https://galaxy.ansible.com/list#/roles/4462/)

For example of all-in-one setup go to https://github.com/kostyrevaa/ansible-koji-infra

Requirements
------------

This role doesn't not provision PostgreSQL setup nor does it creates postgresql users for you.

You should use some other role for that. I use patrik.uytterhoeven.PostgreSQL-For-RHEL6x

Role Variables
--------------

There are some variables in the default/main.yml which can (or needs to) be changed/overriden:

* `koji_dbname`: DB name for koji setup. Default is koji.

* `koji_db_user`: DB's user that own's koji schema. Default is koji.


Dependencies
------------


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: koji_db
      roles:
         - role: patrik.uytterhoeven.PostgreSQL-For-RHEL6x
           postgresql_unix_socket_directories:
             - /tmp
           postgresql_databases:
             - name: koji
           postgresql_users:
             - name: koji
                 pass: "{{ koji_db_pass }}"
                 encrypted: no       # denotes if the password is already encrypted.
           postgresql_user_privileges:
             - name: koji         # user name
               db: koji           # database
               priv: "ALL"        # privilege string format: example: INSERT,UPDATE/table:SELECT/anothertable:ALL

         - role: kostyrevaa.koji-db
  

License
-------

GPLv3

Author Information
------------------

 Send your suggestions and pull requests to https://github.com/kostyrevaa/ansible-koji-db.
 When send PR make sure your changes are backward-compatible.
 Test your changes to role with https://github.com/kostyrevaa/ansible-koji-infra
