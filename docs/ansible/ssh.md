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

Create default key named "id_rsa"
`ssh-keygen -t rsa -b 4096 -C "username@example.com"`

## Keys for GitHub

```sh
ssh-keygen -f ~/.ssh/github-username -t rsa -b 4096 -C "username@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github-username
```

If you can't push code to GitHub due to `git@github.com: Permission denied (publickey)` error, then it probably means that you should add your key to SSH agent.
There is way to add key permanantly so you don't need to do so after every reboot, but IMO this creates security holes.
For me it is not a big deal to add keys after every reboot as i reboot once per week or so.

## Setup multiple SSH identities for different Git accounts

Empty content of file

```sh
> ~/.config/Code/User/settings.json
```

Place configuration in file.

```sh
cat <<EOT >> ~/.ssh/config
# https://stackoverflow.com/questions/4665337/git-pushing-to-remote-github-repository-as-wrong-user/12438179
Host username1.github.com
    HostName github.com
    User username1
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/github-username1
    IdentitiesOnly yes
Host username2.github.com
    HostName github.com
    User username2
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/github-username2
    IdentitiesOnly yes
EOT
```

https://www.jeffgeerling.com/blog/2018/cloning-private-github-repositories-ansible-on-remote-server-through-ssh
