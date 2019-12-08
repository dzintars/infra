# Random notes

- Install Bastion VM in KVM

Set Up Bastion via Ansible (TFTP, Matchbox, HAProxy, DNS, DHCP)
Bastion will take all incomming traffic and route that to Master nodes
TFTP will serve small ignition files for PXE boot so we dont tneed manually set up k8s nodes.

CoreOS is meant to be imutable, throw away and easy to redeploy via ignition mechanism.
[How to install python in CoreOS](https://www.reddit.com/r/coreos/comments/8kc8wm/how_to_install_python_on_coreos_under_core_user/)

Create TFTP server and host ignition files
Run CoreOS VMs via PXE boot and pass `coreos.first_boot=1` to boot argument.

I should have a Ansible playbooks to set up cluster.


----------------

# Prepare Bastion VM

## Create VM Shell script

Create virtual bridge network
Download Fedora Server ISO
Create password
Caveats

## Create Kickstart file

## Add Bastion to hosts

## Create Ansible inventory file

## Ansible Ping bastion

## Update Bastion OS

```sh
ansible all -m ping -i inventory
```

```sh
systemctl start named-chroot.service
systemctl restart named-chroot.service
systemctl enable --now matchbox.service
systemctl enable --now tftp.service
systemctl start tftp.service
systemctl start haproxy.service

systemctl status named-chroot.service
systemctl status dhcpd.service
systemctl status firewalld.service
systemctl status matchbox.service
systemctl status tftp.service
systemctl status haproxy.service
```
