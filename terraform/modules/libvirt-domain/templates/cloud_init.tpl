#cloud-config

# TODO: cluster name and fqdn IMO should come from Vault's KV store
fqdn: ${hostname}.${subdomain}.${root_domain}
hostname: ${hostname}

packages:
  - qemu-guest-agent

runcmd:
  - [ systemctl, daemon-reload ]
  - [ systemctl, enable, qemu-guest-agent ]
  - [ systemctl, start, qemu-guest-agent ]
  - [ curl, -o, /etc/ssh/trusted-user-ca-keys.pem, "https://vault.oswee.com/v1/ssh-client-signer/public_key" ]
  - [ chmod, 0600, /etc/ssh/trusted-user-ca-keys.pem ]
  - [ sed, -i, -e, "$aTrustedUserCAKeys /etc/ssh/trusted-user-ca-keys.pem", /etc/ssh/sshd_config ]
  - [ systemctl, restart, sshd.service ]

users:
#   - name: terraform
  - name: fedora
#   - name: test
#     sudo: ['ALL=(ALL) NOPASSWD:ALL']
#     groups: users, wheel
#     shell: /bin/bash
#     ssh_import_id:
#     lock_passwd: false
#     passwd: $6$J.GyJJBeV05c7FkF$Y2poMCgFMT.kgQpkMaraj70idTEOSlZJKXApUs9eoYnANJB.s326Co6C3s7qhVevOXtMDOAuQ3TX2TjORAQSi. #"pass"

ssh_deletekeys: true

ssh_pwauth: true
chpasswd:
  list: |
     root:root
  expire: false

growpart:
  mode: auto
  devices: ['/']

resize_rootfs: true

timezone: ${time_zone}
