# ansible-workstation-configs

## Description
These are the Ansible playbooks and roles I use to provision my personal
workstations and are provided here as a reference to others looking for ideas
on how to setup their workstations and/or automate provisioning them. In this
repo you will find my dotfiles including zshrc, vimrc, etc.

## IMPORTANT Disclaimer
Feel free to use this as a basis for your own setup, but note that *I don't
intend for anyone to run this against their machines directly as-is*. **Do not
blindly run these playbooks against any of your machines. Doing so may result
in permanent data loss or require significant work to undo. Use this as an
example to build your own.** If you want to build this configuration as-is,
use a fresh VM without anything you want to lose on it. Also, I recommend at
least changing the username defined in `group_vars`. 

## How It Use
Fork this repo, read over it, edit as necessary. **Make it yours**. To apply
this config, start with a fresh install of your favorite linux distro (Ubuntu
20.04 LTS is the only supported as-is; substitute with whatever distro you've
redesigned your fork to support) and install Ansible on it using the
recommended method. After that you can use `ansible-pull` to fetch and run the
playbooks on your machine like so:

    ansible-pull -oKU 'ssh://git@github.com/yourghpage/yourrepo.git'


