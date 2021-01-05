Role Name
=========

[creating_guests_with_virt_install](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-guest_virtual_machine_installation_overview-creating_guests_with_virt_install)

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

Common Errors
----------------

3) [!] Installation source (Error setting up software source)   !!! Check network settings. Don't use cdrom and repo tags in kickstart.
4) [!] Software selection (Error checking software selection)

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).


# - name: create the qemu disk images
#   action: qemu-img dest=/home/dzintars/kvm/pools/bastion/bastion.ocp.example.com.qcow2 size=10 format="qcow2" options="preallocation=metadata"
#   with_items: disks
#   # delegate_to: localhost

# TODO: Change hardcoded home directory

# Delete kickstart file

-x 'console=ttyS0,115200 headless noshell nofirewire'
-x 'console=ttyS0,115200n8 serial'
-x 'console=ttyS0,115200'
--memballoon virtio \
--nographics \
--noautoconsole \
--wait \
--console pty,target_type=serial \
--mac {{ cluster.nodes["bastion"].mac }} \
--debug
