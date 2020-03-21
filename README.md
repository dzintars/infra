# Openshift 4.2 automated HA cluster setup in Libvirt environment

> ALERT: Firewall and SELinux roles are broken/not-finished. Should be moved close to every role. Not in separate roles.
> Also `group_vars` should be little bit reorganized to move out workstation and bastion configs from `nodes` array.

Target is to achieve fully automated HA cluster setup on single bare metal server/workstation as close as possible to production grade.

This setup uses stand alone "bastion" server which acts as DHCP, DNS, Matchbox, TFTP, iPXE and HAProxy server. For sure, some of those components can be moved into separate servers in more realistic scenario and it is easy doable if needed. For simplicity, i left them all as single machine.

Because of iPXE boot, in theory this setup should be easy reproducible on real bare metal machines without any changes in logic.

My motivation to do all this is to keep learning HA distributed microservice development which involves many requirements, like service discovery, tracing, healthchecks, metrics, CI/CD and so on.
So, the only reasonable and "close to production" solution without paying for my potential mistakes to AWS/GCP/Azure, was to use Kubernetes or OpenShift.

I started to write K8s cluster Ansible project based on Fedora CoreOS, but stuck at point of dynamic TLS certificate distribution to every node based on its profile. 99% tutorials and documentation shows how to SSH into every node and upload subset of certs to that node. But that is not what I want. I want to achieve that CoreOS machine at its ignition stage goes to... somewhere... (Hashicorp Vault or SPIFFE/SPIRE server) and grabs its certificates from there. But i failed because of lack of expertiese.

So i left that project till i will not find a solution.

Anyway, i think OpenShift is a good alternative to plain K8s. It has reasonable defaults and opinionated rules.

## Good to know

Full installation takes about 45-60 minutes.
OpenShift 4.2 are int REALLY active development and there could be many edge cases and issues where some non-standard workarounds are required.
Be ready to deal with incomplete or outdated documentation.

## Secrets

Before using this project, you should create a set of ansible-vault secrets for your own use.
For example:

- Root password for guest machines
- Ansible user password for Bastion server

## How to use

A good starting point is Docs directory.

First head into `group_vars` directory and tweak all variables you would like to tweak. Like network IP, host IP last octets, domain name, cluster name etc.
You can adjust cluster nodes resource limits as well, like vCPU, RAM, Volume etc.

I tried to avoid any "magic" variables as much as possible, but feel free to look into `roles` and to see what each role is doing.

1. Replace content of `pull_secret` and `ssh_key` files in `roles/deploy_ignition/files/` with your own ansible-vault artifacts.
   Alternatively you can edit `roles/deploy_ignition/templates/install-config.yaml.j2` template and to place your secrets as plain text there.

Read `roles/deploy_ignition/README.md` for more details.

## Prerequisites

- Libvirt
- KVM
- Ansible
- Python3.7

## Resource requirements for +/- working solution

- 64GB of RAM
- 12 core CPU
- 200GB space on drives

## Errors

I tried to collect errors and gotchas i seen as well provided seen solutions or pointers to solutions.

## Library and app requirements for Workstation

```sh
sudo dnf install -y python3-netaddr
```

```sh
virt-install \
    --connect qemu:///system \
    --name bootstrap.ocp.example.local \
    --description 'RedHat CoreOS bootstrap node' \
    --accelerate \
    --vcpus 2 \
    --cpu host \
    --ram 2048 \
    --disk path=/home/dzintars/kvm/pools/test/bootstrap.ocp.example.local,size=10,cache=writeback,format=qcow2,io=threads,bus=virtio  \
    --pxe \
    --network bridge=virbr0,model=virtio \
    --prompt \
    --mac 00:1a:4a:16:01:28 \
    --os-type linux \
    --os-variant virtio26 \
    --console pty,target_type=serial \
    --nographics \
    --boot hd,network \
    --debug
```

```sh
virt-install \
    --connect qemu:///system \
    --name workstation.setup \
    --description 'RedHat CoreOS bootstrap node' \
    --accelerate \
    --vcpus 2 \
    --cpu host \
    --ram 2048 \
    --disk path=/home/dzintars/kvm/pools/test/workstation.setup,size=10,cache=writeback,format=qcow2,io=threads,bus=virtio  \
    --pxe \
    --network bridge=virbr0,model=virtio \
    --prompt \
    --os-type linux \
    --os-variant virtio26 \
    --console pty,target_type=serial \
    --nographics \
    --boot hd,network \
    --debug
```

curl -s https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux-4.2.7.tar.gz | tar -xzf - -C /usr/local/bin/ oc
