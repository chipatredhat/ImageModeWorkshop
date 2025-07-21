#!/bin/bash

# Install novnc:
cd /tmp
git clone https://github.com/chipatredhat/novnc.git
ansible-galaxy collection install community.crypto ansible.posix community.general
cd novnc/ansible && ansible-playbook install_novnc_and_tigervnc-server.yml 

# Install VSCode:
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
sudo dnf -y install code

# Install Gitea:
sudo groupadd --system git
sudo adduser --system --shell /bin/bash --comment 'Git Version Control' --gid git --home-dir /home/git --create-home git
sudo mkdir -p /var/lib/gitea/{custom,data,log}
sudo chown -R git:git /var/lib/gitea/
sudo chmod -R 750 /var/lib/gitea/
sudo mkdir /etc/gitea
sudo chown root:git /etc/gitea
sudo chmod 750 /etc/gitea
sudo cp /tmp/ImageModeWorkshop/files/gitea.ini /etc/gitea/app.ini
sudo chown git:git /etc/gitea/app.ini
sudo chmod 640 /etc/gitea/app.ini
GITEA_VERSION=$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/go-gitea/gitea/releases/latest | awk -F/v '{print $2}')
curl -s https://dl.gitea.com/gitea/${GITEA_VERSION}/gitea-${GITEA_VERSION}-linux-amd64 > gitea
sudo mv gitea /usr/local/bin/gitea
sudo chmod +x /usr/local/bin/gitea
sudo chcon -t bin_t /usr/local/bin/gitea
sudo restorecon /usr/local/bin/gitea
sudo cp /tmp/ImageModeWorkshop/files/gitea.service /etc/systemd/system/gitea.service
sudo systemctl daemon-reload
sudo systemctl enable gitea --now
echo "Sleeping 30 seconds to allow gitea to startup"
sleep 30
sudo -u git /usr/local/bin/gitea admin user create --username lab-user --password redhat --email lab-user@example.com --must-change-password=false --config /etc/gitea/app.ini 
