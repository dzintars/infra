#cloud-config

packages:
  - qemu-guest-agent

runcmd:
  - [ systemctl, daemon-reload ]
  - [ systemctl, enable, qemu-guest-agent ]
  - [ systemctl, start, qemu-guest-agent ]
  - [ curl, -o, /etc/ssh/trusted-user-ca-keys.pem, "https://vault.oswee.com/v1/ssh-client-signer/public_key" ]

# TODO: cluster name and fqdn IMO should come from Vault's KV store
fqdn: ${hostname}.${subdomain}.${root_domain}
hostname: ${hostname}
users:
  - name: ${user}
    sudo: ALL=(ALL) NOPASSWD:ALL
    lock_passwd: false
    ssh_authorized_keys:
      # TODO: This should be injected from the Vault
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/0ttzKRwT5/8Lxq+cUhzDGCIEV31T2Z4lqLPMKMMHMBtcqChQdNrKACS3gydM3qXhxeZoERP9GhPwqiaoM5eLS28lyHGRo1uYjqpAmaGwyVgOCPA9ObVGWvkOj1ULB7+2dn96tS8v97KkHkM0JYCKSwTKg44OIznOeIny8jHrOIYmsy4R85eC/e47+3X33/kB8fbA5Br4YZi1E1LuwTx/dyf9yzq4kgIcQh0pV9pMClPHKCZ+bYKsAPPT7Q48SG3IfXt0OcZd7huVth/dyHkfasbwZwuZ+2C3BEyLFmTu8Cmn6sVr0wTggPoVb85bIx4Mk2bAk35m5ihw4XzW9KBFuhpEooxJRiqvkBQ/WjfPGD3NZqX7R6FM1aYFOWHbQCLgRQP51cMshaG/1mqT1/P/ssjJDN4EWvFKg3lI/iL7/1ETzUk9t0i1hCBSn+FewTafCJhCIMNn4QJqbpxYGRORrY6YMyXuVaJ0PjYm0gAPKtk3PtiiYAe7ACdcUz9am/M= dzintars@workstationAAAAB3NzaC1yc2EAAAADAQABAAABgQC/0ttzKRwT5/8Lxq+cUhzDGCIEV31T2Z4lqLPMKMMHMBtcqChQdNrKACS3gydM3qXhxeZoERP9GhPwqiaoM5eLS28lyHGRo1uYjqpAmaGwyVgOCPA9ObVGWvkOj1ULB7+2dn96tS8v97KkHkM0JYCKSwTKg44OIznOeIny8jHrOIYmsy4R85eC/e47+3X33/kB8fbA5Br4YZi1E1LuwTx/dyf9yzq4kgIcQh0pV9pMClPHKCZ+bYKsAPPT7Q48SG3IfXt0OcZd7huVth/dyHkfasbwZwuZ+2C3BEyLFmTu8Cmn6sVr0wTggPoVb85bIx4Mk2bAk35m5ihw4XzW9KBFuhpEooxJRiqvkBQ/WjfPGD3NZqX7R6FM1aYFOWHbQCLgRQP51cMshaG/1mqT1/P/ssjJDN4EWvFKg3lI/iL7/1ETzUk9t0i1hCBSn+FewTafCJhCIMNn4QJqbpxYGRORrY6YMyXuVaJ0PjYm0gAPKtk3PtiiYAe7ACdcUz9am/M= dzintars@workstation

growpart:
  mode: auto
  devices: ['/']

resize_rootfs: true

timezone: ${time_zone}

# vim:syntax=yaml
