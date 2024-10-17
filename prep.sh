#!/bin/sh
# This prep script will install git and ansible core, then clone the repo and start the build
# You can use it by running: curl -s https://raw.githubusercontent.com/chipatredhat/ImageModeWorkshop/refs/heads/main/prep.sh | bash
# Or pass your variables  with: curl -s https://raw.githubusercontent.com/chipatredhat/ImageModeWorkshop/refs/heads/main/prep.sh | bash -s -- <your_token> <RH_REGISTRY_ACCOUNT> <RH_REGISTRY_TOKEN/PASSWORD>
sudo dnf -y install git ansible-core
cd /tmp
git clone https://github.com/chipatredhat/ImageModeWorkshop.git
cd ImageModeWorkshop
./build.sh $1 $2 $3