1) Create master.yaml file with configuration
2) Download FCCT tool
3) Place FCCT tool into /usr/local/bin, make executable and check the owner
4) Run the `fcct --strict --pretty --input master_config.fcc --output master_config.ign` tool apn pass master.yaml file to it
5) Create master.ign file and paste generated content of fcct tool
6) Upload the ignition configs to the Bastion ignition directory

[Fedora CoreOS - Getting Started](https://docs.fedoraproject.org/en-US/fedora-coreos/getting-started/)

[FCCT Download - coreos/fcct](https://github.com/coreos/fcct/releases)

[FCCT Getting started](https://github.com/coreos/fcct/blob/master/docs/getting-started.md)

roles/install_matchbox/files/ignition