#!/bin/sh

function build_image {
    sudo podman run --rm -it --privileged --pull=newer --security-opt label=type:unconfined_t -v $(pwd)/${2}config.toml:/config.toml:ro -v $(pwd)/output:/output -v /var/lib/containers/storage:/var/lib/containers/storage -v /etc/pki:/etc/pki registry.redhat.io/rhel9/bootc-image-builder:latest --type ${1} --config /config.toml registry.example.com/rhel9/rhel-bootc-app:latest
    exit
}

function menu {
PS3=$'\n'"Select an image to build: "
select menuitem in iso qcow2 vmdk gce ami raw Quit # PackageMode
do
    case $menuitem in
        "iso")
            build_image iso kickstart_;;
        "qcow2")
            build_image qcow2;;
        "vmdk")
            build_image vmdk;;
        "gce")
            build_image gce;;
        "ami")
            build_image ami;;
        "raw")
            build_image raw;;                                                            
         "Quit")
           echo -e "Good Bye \n\n"
           exit;;
        *)
           MENU;;
    esac
done

}

menu
