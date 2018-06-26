#!/bin/sh
sudo virt-install --pxe --network network=imnet,mac="de:ad:be:ef:fa:d5" --name "AAP"  --memory 16384 --disk size=40 --nographics --boot menu=on,useserial=on --osinfo rhel9.4 --noautoconsole