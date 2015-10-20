# WORK IN PROGRESS

# koji-dev
Developer workflow for [koji](https://fedorahosted.org/koji/) developers.

## Pre-Reqs

This developer workflow takes advantage of some tools available externally.

These will need to be installed on your system and are available for both
[Fedora](https://getfedora.org/) and [CentOS](https://www.centos.org/).
(Though CentOS will need [EPEL](https://fedoraproject.org/wiki/EPEL) added)

### Tito

From the official [Tito project page](https://github.com/dgoodwin/tito)

"Tito is a tool for managing RPM based projects using git for their source
code repository."


### Ansible

From the official [Ansible Documentation](http://docs.ansible.com/ansible/index.html)

"Ansible is an IT automation tool. It can configure systems, deploy software,
and orchestrate more advanced IT tasks such as continuous deployments or zero
downtime rolling updates."

### Mock

From the official [Mock Documentation](https://fedoraproject.org/wiki/Mock)

"Mock is a tool for building packages. It can build packages for different
architectures and different Fedora or RHEL versions than the build host has.
Mock creates chroots and builds packages in them. Its only task is to reliably
populate a chroot and attempt to build a package in that chroot."

## Example workflow

### Setup the DevEnv
Use the `koji-dev.yml` playbook found in the `ansible-koji-dev` directory to
deploy a "developer environment" of koji (we will call this a "DevEnv" for the
duration of this document).

First we will need to edit the inventory file aptly named `inventory.txt` found
withing the `ansible-koji-dev` directory. You can have this all be the same
machine if you'd like an "all-in-one" DevEnv but if you prefer a scaled out
environment in order to test in a more "real world" scenario then feel free to
assign the different host categories with different machines.

An example of a single "all-in-one" DevEnv inventory is below:

    [koji_db]
    209.132.184.235
    
    [koji_ca]
    209.132.184.235
    
    [koji_hub]
    209.132.184.235
    
    [koji_web]
    209.132.184.235
    
    [koji_builder]
    209.132.184.235

Once inside the `ansible-koji-dev` directory we can deploy our DevEnv using the
following command:

    ansible-playbook koji-dev.yaml -i inventory -u root

Alternatively if you would like to use an user with sudo instead of root:

    ansible-playbook koji-dev.yaml -i inventory -u someuser -s

### Iterative development
In this scenario we'll assume you have a topic branch of koji in your own git
clone and want to deploy that.

The script `build-koji-dev.sh` is provided to automate the task of building the
packages and creating a temporary repository that will be transfered to the
node(s) of the DevEnv using the Ansible playbook `koji-dev-update.yml` found
within the directory `ansible-koji-dev`

#### Build RPMs with tito

    cd ~/src/koji/
    git checkout my-topic-branch
    ~/src/dev/koji-dev/build-koji-dev.sh -b -m epel-7-x86_64

#### Update your DevEnv

    ansible-playbook koji-dev-update.yml -i inventory -u root

Again, alternatively this can be done with a sudo enabled user instead of root:

    ansible-playbook koji-dev-update.yaml -i inventory -u someuser -s
