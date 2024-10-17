## Files to setup an Image Mode Workshop on a system that supports virtualization  
**REQUIREMENTS:** git and ansible-core  
**EX:** `sudo dnf -y install git ansible-core`   

## Instructions:  
`git clone https://github.com/chipatredhat/ImageModeWorkshop.git`  
`cd ImageModeWorkshop`  
`./build.sh`  
**API Tokens can be created at:** https://access.redhat.com/management/api  
**Registry Service Accounts can be created at:**  https://access.redhat.com/terms-based-registry  


## Run this scripted by logging in and executing:  
`curl -s https://raw.githubusercontent.com/chipatredhat/ImageModeWorkshop/refs/heads/main/prep.sh | bash -s -- <RH_API_TOKEN> <RH_REGISTRY_ACCOUNT> <RH_REGISTRY_TOKEN/PASSWORD>`  
**NOTE:**  There will be a | in the registry service account that must be escaped with a \ in front of it  

## After running the above installation, Instructions for the workshop will be placed in:
### /home/{{ USERNAME }}/Instructions