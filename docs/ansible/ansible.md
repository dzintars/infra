# Ansible

## reads

Good repository of Ansible organization [Fedora Copr](https://github.com/devnullcake/ansible-role-copr-repository)

## Usage

Before starting, update `hosts` and `group_vars` according to your needs. For example you probably want to update all IP addresses, node names, domain, cluster name, etc.

## Ansible commands

```sh
# Create Bastion VM
ansible-playbook play/workstation.yml --tags bastion:create --ask-vault-pass
ansible-playbook play/bastion.yml --ask-vault-pass

# Disable Bastion and Cptnod variables


```

```sh
ansible-playbook play/setup_bastion.yml --tags --ask-vault-pass
ansible-playbook play/setup_bastion.yml --tags ignition:config --ask-vault-pass

ansible-playbook play/setup_workstation.yml --tags openshift:provision --ask-vault-pass
ansible-playbook play/setup_workstation.yml --tags openshift --ask-vault-pass
ansible-playbook play/setup_workstation.yml --tags openshift:cleanup --ask-vault-pass
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

## Ansible Galaxy

Bootstrap new empty role

```sh
ansible-galaxy role init roles/<role-name>
```

Install all requirements

```sh
ansible-galaxy install -r requirements.yml
```