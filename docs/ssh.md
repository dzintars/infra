# SSH

This is a good article how to copy your ssh key into main clipboard

[Adding a new SSH key to your GitHub account](https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)

```sh
xclip -sel clip < ~/.ssh/id_rsa.pub
```

```sh
ssh-keygen -t rsa -b 4096 -C "username@example.com"
ssh-copy-id -i ~/.ssh/id_rsa user@host
ssh-add ~/.ssh/id_rsa
```

Enter passphrase for key '/home/dzintars/.ssh/id_rsa':