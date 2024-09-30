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
RHEL94="17b013f605e6b85affd37431b533b6904541f8b889179ae3f99e1e480dd4ae38"
# Download the ISO:
sudo mkdir /mnt/iso
sudo chmod 777 /mnt/iso
curl -H "Authorization: Bearer $token" -L https://api.access.redhat.com/management/v1/images/$RHEL94/download -o /mnt/iso/rhel-9.4-x86_64-boot.iso

# Install ansible-galaxy requirements
ansible-galaxy install -r files/requirements.yml

# Now run the playbook
ansible-playbook Build_Image_Mode_Workshop.yml -e PMUSERNAME="${PMUSERNAME}" -e PMPASSWORD="${PMPASSWORD}" -i localhost,

# Clear any history that may contain sensitive information
history -c