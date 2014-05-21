Vagrant base provides a foundation for setting up your vagrant development environment. It includes PHP 5.5, MySql and nginx.

## Setup

Requires vagrant and virtual box to be installed

1. Clone repo
2. run `vagrant up` then `fab vm boot_env` from repo root
3. profit at localhost:8080

## SSH Forwarding

To allow the Vagrant box to use your ssh keys, make sure the ssh agent can use your keys (`ssh-add -L`) and add them if needed (`ssh-add ~/.ssh/id_rsa`) and make sure your ssh config allows agent forwarding on localhost:

```
Host localhost
	ForwardAgent yes
```

You can now `vagrant ssh` and `ssh -T git@github.com` to test your credentials (assuming your ssh key is registered with Github).
