# Git

```sh
ssh_askpass: exec(/usr/libexec/openssh/ssh-askpass): No such file or directory
Host key verification failed.
fatal: Could not read from remote repository.
```

SOLUTION: `~/.ssh/known_hosts` should know IPs and signatures of Git #GitHub servers.
