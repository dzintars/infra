# Bastion

# Setup instructions

1) Add bastion host to `sudo vim /etc/hosts`. Add line `192.168.1.254    bastion    bastion.ocp.example.com`
2) CD into bastion directory and `./install-vm.sh`. This will set up an new virtual machine.
3) Copy ssh key into VM `ssh-copy-id -i ~/.ssh/id_rsa.pub dzintars@bastion`
4) From root of this repo execute `ansible-playbook play/setup_cluster.yml --tags="cluster:provision" --ask-become-pass  --ask-vault-pass`
5) CD into `coreos` directory and execute `./install-vm.sh`. This should set up iPXE bootect Fedora CoreOS VM.

### Some Kickstart configs 

```sh
url --url="https://dl.fedoraproject.org/pub/fedora-secondary/development/rawhide/Everything/ppc64le/os/"

###########################################################################################
# User Accounts
# openssl passwd -1 password
# or
# python -c 'import crypt,getpass;pw=getpass.getpass();print(crypt.crypt(pw) if (pw==getpass.getpass("Confirm: ")) else exit())'
###########################################################################################


rootpw --iscrypted $6$HpkbIwlR0GAMPaDz$eNnNoeEREePOWEE05sVng1cUN5G8LVj8LagVfM6d/6lYnVksfiR/XFtKMrPnNoeEREePkdE4VnLx7IVjdyjaIu. --lock
# user --name=ocp --password=$6$HpkbIwlR0GAMPaDz$eN0sfd8REePOWEE0EW8LVj8LagVfM6d/6lYnVksfiR/XFtKMrPeegrer90H3kdE4VnLx7IVjdyjaIu. --iscrypted --groups=wheel
# user --name=dzintars --password $1$6lY38wf0ewsfiRiRq.XeAO9QM/DWFe4j30 --iscrypted --groups=wheel --gecos="Dzintars"
user --name=dzintars --password $6$HpkbIwlR0GAMPaDz$eNvns0d8f9kFff5sVng1cUN5G8LVj8LagVfM6d/6lYnVksfiR/XFtKergergd8VdccEkdE4VnLx7IVjdyjaIu. --iscrypted --groups=wheel --gecos="Dzintars"

 # selinux --enforcing (Enabled by default for Fedora)
 # selinux --permissive
 # selinux --disabled
 
# firewall --enabled --http --ssh --ftp --port=https:tcp --port=ipp:tcp
```

Don't ask for root password of wheel user

[Remove sudo Password Prompt](http://jonmoore.duckdns.org/index.php/linux-articles/58-remove-sudo-password-prompt)

```sh
sudo visudo
<user> ALL=(ALL) NOPASSWD: ALL
sudo -k
sudo ls
```

```sh
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: ModuleNotFoundError: No module named 'semanage'
fatal: [bastion.ocp.example.com]: FAILED! => {"changed": false, "msg": "Failed to import the required Python library (libsemanage-python) on bastion.ocp.example.com's Python /usr/bin/python3.7. Please read module documentation and install in the appropriate location"}
```

## Errors seen

```sh
usr/libexec/coreos-installer: line 622: warning: command substitution: ignored null byte in input
```

## Commands

Check status

```sh
systemctl status tftp
systemctl status dhcpd
systemctl status matchbox
systemctl status haproxy
systemctl status named-chroot
```

Start services

```sh
systemctl start tftp
systemctl start dhcpd
systemctl start matchbox
systemctl start haproxy
systemctl start named-chroot
```

Retart services

```sh
systemctl restart tftp
systemctl restart dhcpd
systemctl restart matchbox
systemctl restart haproxy
systemctl restart named-chroot
```
