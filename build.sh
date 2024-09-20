#!/bin/sh

# Make sure you can get passwordless root
[[ $(sudo -A whoami) != "root" ]] && echo "You need to have passwordless sudo access" && exit

# Install ansible-core if necessary, and then do the rest in the playbook
[[ $(command -v ansible-playbook) ]] || sudo dnf -y install ansible-core
