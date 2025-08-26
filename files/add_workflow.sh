#!/bin/bash

cd /tmp
git clone https://github.com/chipatredhat/Image-Mode-Demo.git
#ansible-galaxy collection install -r ./Image-Mode-Demo/ansible/roles/requirements.yml
ansible-playbook Image-Mode-Demo/ansible/setup-demo.yml 
