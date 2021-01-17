#cloud-config

packages:
  - qemu-guest-agent

runcmd:
  - [ systemctl, daemon-reload ]
  - [ systemctl, enable, qemu-guest-agent ]
  - [ systemctl, start, qemu-guest-agent ]
  - [ curl, -o, /etc/ssh/trusted-user-ca-keys.pem, "https://vault.oswee.com/v1/ssh-client-signer/public_key" ]
  - [ sed, "$ a TrustedUserCAKeys /etc/ssh/trusted-user-ca-keys.pub", /etc/ssh/sshd_config ]
  - [ systemctl, restart, sshd.service ]

# TODO: cluster name and fqdn IMO should come from Vault's KV store
fqdn: ${hostname}.${subdomain}.${root_domain}
hostname: ${hostname}
users:
  - default
  - name: ${user}
    sudo: ALL=(ALL) NOPASSWD:ALL
    lock_passwd: false
    passwd: $6$J.GyJJBeV05c7FkF$Y2poMCgFMT.kgQpkMaraj70idTEOSlZJKXApUs9eoYnANJB.s326Co6C3s7qhVevOXtMDOAuQ3TX2TjORAQSi. #"pass"

growpart:
  mode: auto
  devices: ['/']

resize_rootfs: true

timezone: ${time_zone}

# vim:syntax=yaml
