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
ansible-playbook -i ~/dz_rpi_config/ansible/hosts ~/dz_rpi_config/ansible/initial_setup_playbook.yml
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

## Realtime Testing

This automated config provides an easy way to get the `PREEMPT_RT` kernel set up using the experimental kernel builds here: https://forums.raspberrypi.com/viewtopic.php?t=388298

Cyclictest results:

```
user@computer:~ $ sudo cyclictest -a -t -p99
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 7.60 3.43 1.37 2/238 2910           

T: 0 ( 2907) P:99 I:1000 C:  74458 Min:      1 Act:    1 Avg:    2 Max:      13
T: 1 ( 2908) P:99 I:1500 C:  49639 Min:      1 Act:    1 Avg:    2 Max:       9
T: 2 ( 2909) P:99 I:2000 C:  37229 Min:      1 Act:    1 Avg:    2 Max:      10
T: 3 ( 2910) P:99 I:2500 C:  29783 Min:      1 Act:    1 Avg:    2 Max:      11
```

This is working, similar to what I reported with the self-built kernel [in the Wiki](https://github.com/danzimmerman/dz_rpi_config/wiki/preempt_rt_kernel#10-test-the-installation).