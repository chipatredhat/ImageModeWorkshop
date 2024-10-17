#!/bin/sh
if [ "$1" = "" ] ; then read -p "What is the name of the system you wish to start? " SYSNAME ; else SYSNAME=$1 ; fi

sudo virt-install --pxe --network network=default --name ${SYSNAME}  --memory 4096 --disk size=20 --nographics --boot menu=on,useserial=on --osinfo rhel9.4
