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
    echo "deleting vm"
    sudo virsh destroy $1 && sudo virsh undefine $1 --remove-all-storage
    create_vm $1 $2
    else
    echo -e "\nexiting\n"
    exit
    fi
}

function create_vm {
    sudo virt-install --pxe --network network=default,mac="${2}" --name "${1}"  --memory 4096 --disk size=20 --nographics --boot menu=on,useserial=on --osinfo rhel9.4
	echo "this ran create_vm on $1 with MAC $2"
    exit
}

function menu {
PS3=$'\n'"Select a server to build: "
select menuitem in PackageMode ImageMode AppServer Quit
do
    case $menuitem in
        "PackageMode")
            check_vm PackageMode de:ad:be:ef:fa:d1;;
        "ImageMode")
           check_vm ImageMode de:ad:be:ef:fa:d2;;
        "AppServer")
           check_vm AppServer de:ad:be:ef:fa:d3;;
         "Quit")
           echo -e "Good Bye \n\n"
           exit;;
        *)
           MENU;;
    esac
done

}

menu