for i in $(podman images | grep example | awk '{print $3}') ; do podman image rm $i ; done
sudo podman stop registry
sudo podman rm registry
sudo rm -rf /root/registry/data/docker
sudo podman run -d --name registry --privileged -p 443:5000 -v /root/registry/certs:/certs -v /root/registry/data:/var/lib/registry:Z -e REGISTRY_HTTP_TLS_CERTIFICATE=certs/wildcard.example.com.crt -e REGISTRY_HTTP_TLS_KEY=certs/wildcard.example.com.key registry:latest
for i in $(sudo virsh list --name --all) ; do sudo virsh destroy $i ; sudo virsh undefine $i --remove-all-storage ; done
