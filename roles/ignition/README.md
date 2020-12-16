Install openshift-install CLI and deploy ignition configs to Matchbox
=========

This role downloads and installs `openshift-install-linux-4.2.0` CLI tool and then automatically deploys ignition configs for bootstrap, master and worker nodes into Bastion's Matchbox /ignition directory.
To run this playbook execute:

```sh
ansible-playbook play/setup_bastion.yml --tags="ignition" --ask-vault-pass
```

Every time you need a fresh set of ONLY ignition configs you can execute:

```sh
ansible-playbook play/setup_bastion.yml --tags="ignition:config" --ask-vault-pass
```
This command will save some time by skiping the CLI tool installation process and will generate just ignition files and authentication credentials.

`--ask-vault-pass` is required if you use encrypted secrets files from `files` directory.
If you use plain text variables in template, then you can drop `--ask-vault-pass` attribute.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
