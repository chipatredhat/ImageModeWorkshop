#!/bin/sh

# Make sure you can get passwordless root
[[ $(sudo -A whoami) != "root" ]] && echo "You need to have passwordless sudo access" && exit

# Install ansible-core if necessary, and then do the rest in the playbook
[[ $(command -v ansible-playbook) ]] || sudo dnf -y install ansible-core

# Download the RHEL ISO using a token:
# Put together based on Ansible instructions at https://access.redhat.com/solutions/7013662
echo -e "\n\nGet an offline API token from https://access.redhat.com/management/api\n"
read -p "What is your offline token? " offline_token
# Get a download token:
token=$(curl https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token -d grant_type=refresh_token -d client_id=rhsm-api -d refresh_token=$offline_token | jq --raw-output .access_token)
# Use the Red Hat Enterprise Linux 9.4 Binary DVD SHA-256 Checksum from https://access.redhat.com/downloads/content/rhel
RHEL9.4="398561d7b66f1a4bf23664f4aa8f2cfbb3641aa2f01a320068e86bd1fc0e9076"
# Download the ISO:
curl -H "Authorization: Bearer $token" -L https://api.access.redhat.com/management/v1/images/$RHEL/download -o rhel-9.4-x86_64-dvd.iso