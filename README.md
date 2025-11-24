# Raspberry Pi 5 Setup Repository

Semi-automatic setup of a Raspberry Pi with my desired bash additions, packages of interest, etc.

The `main` branch assumes Ubuntu Noble. I'm using Ubuntu Server.

The `bookworm` branch assumes Raspberry Pi OS based on Debian Bookworm.

## Initial Setup

This assumes that a new SD card has been imaged with Raspberry Pi OS Lite, 64 bit edition, and set up with the following:

 - A hostname compatible with `ansible_setup/hosts` 
 - The user `dan` 
 - SSH public keys for the host computer, SSH-only allowed 

## Ansible Commissioning

Install Ansible from the Ubuntu PPA on the host computer as described here:

https://docs.ansible.com/projects/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu

After cloning the repo into the home directory on a host computer and installing Ansible, you can run:

```
ansible-playbook -i ~/dz_rpi_config/ansible_setup/hosts ~/dz_rpi_config/ansible_setup/playbook.yml
```

After this, `~/.bashrc` will incorporate all the changes in `bash_config/.bashrc_additions` and `~/.bash_aliases` and `~/.inputrc` will be softlinks that point to their counterparts in this repo.

Ansible automatically sets everything up according to the tasks in [`ansible_setup/playbook.yml`](./ansible_setup/playbook.yml). 

So I've cleaned up the `bookworm` branch to remove unnecessary files and scripts and to reflect Ansible's handling of:

 - Cloning this repo and softlinking the Bash setup files
 - Setting up DHCP wired ethernet using `nmcli` and cleaning up unused connections
 - Setting up NetworkManager to do connectivity checks to help auto-switch the default route between wired and wireless interfaces
 - Installing needed `apt` packages
 - Setting up `/boot/firmware/config.txt` for SPI, MCP2515 CANBus, backup battery charging, etc.
 - Installing Miniforge3, creating a Robostack ROS 2 Jazzy environment, and installing `ros-jazzy-desktop`

This list may not include all up-to-date tasks. See `playbook.yml` as the definitive reference.