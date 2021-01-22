#cloud-config

# TODO: cluster name and fqdn IMO should come from Vault's KV store
fqdn: ${hostname}.${subdomain}.${root_domain}
hostname: ${hostname}

packages:
  - qemu-guest-agent
  - jq

write_files:
  - content: |
      #!/bin/sh
      set -eu -o pipefail
      token_path=/root/.vault-token
      ssh_pub_key_path=/etc/ssh/ssh_host_ecdsa_key.pub
      ssh_cert_path=/etc/ssh/ssh_host_ecdsa_key-cert.pub
      echo "Authenticating with Vault"
      curl -sS \
        -X POST \
        -d @- "${vault_addr}/v1/auth/approle/login" <<-EOF | jq -r '.auth.client_token' > $token_path
      {
        "role_id": "${vault_role_id}",
        "secret_id": "${vault_secret_id}"
      }
      EOF
      echo "Successfully authenticated with Vault"
      echo "Signing host cert"
      curl -sS \
        -H "X-Vault-Token: $(cat $token_path)" \
        -X POST \
        -d @- "${vault_addr}/v1/ssh-host-signer/sign/instance" <<-EOF | jq -r .data.signed_key > $cert_path
      {
        "public_key": "$(cat $ssh_pub_key_path)",
        "cert_type": "host"
      }
      EOF
      chmod 0640 $cert_path
      echo "Successfully signed cert"
    path: /etc/vault/sign-host-cert.sh
    permissions: '0644'
    owner: root:root
  - content: |
      [Service]
      ExecStart=/bin/sh /etc/vault/sign-host-cert.sh
      Restart=on-failure
      RestartSec=20
      Type=forking
      [Unit]
      Description=Sign a new host cert on boot, then weekly
      [Timer]
      OnCalendar=weekly
      Persistent=true
      [Install]
      WantedBy=timers.target
    path: /etc/systemd/system/sign-host-certificate.service
    permissions: '0644'
    owner: root:root

runcmd:
  - [ systemctl, daemon-reload ]
  - [ systemctl, enable, qemu-guest-agent ]
  - [ systemctl, start, qemu-guest-agent ]
  # Terraform does not support DSA and ED25519
  - [ rm, -R, /etc/ssh/ssh_host_dsa*]
  - [ rm, -R, /etc/ssh/ssh_host_ed25519*]
  - [ curl, -o, /etc/ssh/trusted-user-ca-keys.pem, "https://vault.oswee.com/v1/ssh-client-signer/public_key" ]
  - [ chmod, 0600, /etc/ssh/trusted-user-ca-keys.pem ]
  - [ sed, -i, -e, "$aTrustedUserCAKeys /etc/ssh/trusted-user-ca-keys.pem", /etc/ssh/sshd_config ]
  - [ systemctl, restart, sshd.service ]
  - [ systemctl, enable, sign-host-certificate.service ]
  - [ systemctl, start, sign-host-certificate.service ]

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

final_message: "**** The system is finally up, after $UPTIME seconds ****"
