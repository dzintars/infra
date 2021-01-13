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

growpart:
  mode: auto
  devices: ['/']

resize_rootfs: true

timezone: ${time_zone}

# vim:syntax=yaml
