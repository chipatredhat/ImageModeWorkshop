#!/bin/sh

# Make sure you can get passwordless root
[[ $(sudo -A whoami) != "root" ]] && echo "You need to have passwordless sudo access" && exit

# Install ansible-core if necessary, and then do what we can in the playbook
[[ $(command -v ansible-playbook) ]] || sudo dnf -y install ansible-core

# Download the RHEL ISO using a token:
# Put together based on Ansible instructions at https://access.redhat.com/solutions/7013662
if [ "$1" = "" ] ; then
echo -e "\n\nGet an offline API token from https://access.redhat.com/management/api\n"
read -p "What is your offline token? " offline_token
else
offline_token=$1
fi

if [ "$3" = "" ] ; then
echo -e "\n\nGet Registry Service Account credentials at https://access.redhat.com/terms-based-registry/\n"
echo -e "NOTE: Personal credentials will work here, but it is not advised\n"
read -p "What is the Account Name: " PMUSERNAME
read -p "What is the Account Token/Password: " PMPASSWORD
else
PMUSERNAME=$2
PMPASSWORD=$3
fi

# Get a download token:
token=$(curl https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token -d grant_type=refresh_token -d client_id=rhsm-api -d refresh_token=$offline_token | jq --raw-output .access_token)
# Use the Red Hat Enterprise Linux 9.4 Binary DVD SHA-256 Checksum from https://access.redhat.com/downloads/content/rhel
RHEL94="398561d7b66f1a4bf23664f4aa8f2cfbb3641aa2f01a320068e86bd1fc0e9076" # Binary DVD
RHEL10="edce2dd6f8e1d1b2ff0b204f89b0659bc9e320d175beb7caad60712957a19608"
# Download the ISO:
sudo mkdir /mnt/iso
sudo chmod 777 /mnt/iso
# Boot.iso:
# curl -H "Authorization: Bearer $token" -L https://api.access.redhat.com/management/v1/images/$RHEL94/download -o /mnt/iso/rhel-9.4-x86_64-boot.iso
# RHEL 9.4 Binary DVD:
curl -H "Authorization: Bearer $token" -L https://api.access.redhat.com/management/v1/images/$RHEL94/download -o /mnt/iso/rhel-9.4-x86_64-dvd.iso
# RHEL 10 Beta DVD
curl -H "Authorization: Bearer $token" -L https://api.access.redhat.com/management/v1/images/$RHEL10/download -o /mnt/iso/rhel-10.0-x86_64-dvd.iso

# Install ansible-galaxy requirements
ansible-galaxy install -r files/requirements.yml

# Now run the playbook
ansible-playbook Build_Image_Mode_Workshop.yml -e PMUSERNAME="${PMUSERNAME}" -e PMPASSWORD="${PMPASSWORD}" -i localhost,

# Tag the RHEL 10 bootc container as latest
podman image tag $(podman images | grep rhel10-beta | awk '{print $3}') registry.redhat.io/rhel10-beta/rhel-bootc:latest

# Clear any history that may contain sensitive information
history -c
