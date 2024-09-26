#!/bin/sh
# This prep script will install git and ansible core, then clone the repo and start the build
# You can use it by running: curl -s 
sudo dnf -y install git ansible-core
git clone https://github.com/chipatredhat/ImageModeWorkshop.git
cd ImageModeWorkshop
./build.sh $1