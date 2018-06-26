#!/bin/sh

function check_vm {
    if [ $(sudo virsh list --name | grep $1) ]
    then
    vm_exists $1 $2
    else
    create_vm $1 $2
    fi
}

function vm_exists {
	read -n 1 -p "The $1 server already exists.  Would you like to delete it and recreate it? (Y/N) " RESPONSE
    if [ "${RESPONSE^}" = "Y" ]
    then
    echo -e "\ndeleting vm...\n"
    sudo virsh destroy $1 && sudo virsh undefine $1 --remove-all-storage
    sed -i "/^$1.*/Id" ~/.ssh/known_hosts
    create_vm $1 $2
    else
    echo -e "\nexiting\n"
    exit
    fi
}

function create_vm {
    sudo virt-install --pxe --network network=imnet,mac="${2}" --name "${1}"  --memory 4096 --disk size=20 --nographics --boot menu=on,useserial=on --osinfo rhel9.4
    exit
}

function menu {
PS3=$'\n'"Select a server to build: "
select menuitem in ImageMode AppServer Pipeline Quit # PackageMode
do
    case $menuitem in
        "PackageMode")
            check_vm PackageMode de:ad:be:ef:fa:d1;;
        "ImageMode")
           check_vm ImageMode de:ad:be:ef:fa:d2;;
        "AppServer")
           check_vm AppServer de:ad:be:ef:fa:d3;;
        "Pipeline")
           check_vm Pipeline de:ad:be:ef:fa:d4;;
         "Quit")
           echo -e "Good Bye \n\n"
           exit;;
        *)
           MENU;;
    esac
done

}

menu