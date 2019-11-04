# Ansible

## Usage

Before starting, update `hosts` and `group_vars` according to your needs. For example you probably want to upade all IP addresses, node names, domain, cluster name, etc.

## Ansible commands

```sh
ansible-playbook define-ocp-vms.yml --ask-become-pass
```

## Ansible Vault

```sh
ansible-vault create encrypted-file.txt
ansible-vault view encrypted-file.txt
ansible-vault edit encrypted-file.txt
ansible-vault rekey encrypted-file.txt

ansible-vault encrypt encrypted-playbook.yml
ansible-vault decrypt encrypted-playbook.yml

ansible-playbook encrypted-playbook.yml --ask-vault-pass

ansible-playbook encrypted-playbook.yml --vault-password-file mypass.txt

ansible-vault encrypt_string
ansible-vault encrypt_string --stdin-name "MyPassword"

echo -n "MySecretPassword123" | ansible-vault encrypt_string


ansible-vault encrypt_string --vault-id roles/deploy_ignition/files/pull_secret --stdin-name 'pull_secret'
```

