# Raspberry Pi 5 Setup Repository

Semi-automatic setup of a Raspberry Pi with my desired bash additions, packages of interest, etc.

The `main` branch assumes Ubuntu Noble. I'm using Ubuntu Server.

The `bookworm` branch assumes Raspberry Pi OS based on Debian Bookworm.

## Initial Setup

Install Ansible from the Ubuntu PPA



After cloning the repo into my home directory:

```
ansible-playbook -i ~/dz_rpi_config/init-setup-playbook/hosts ~/dz_rpi_config/init-setup-playbook/playbook.yml
```

After this, `~/.bashrc` will incorporate all the changes in `bash_config/.bashrc_additions` and `~/.bash_aliases` and `~/.inputrc` will be softlinks that point to their counterparts in this repo.

## dtoverlay Setup 

### CANBus

This is now handled by Ansible

## Network Setup

This copies the file `network/99-eth0-dhcp.yaml` to `/etc/netplan` and sets permissions.

## Install Conda

Download the latest `miniforge3` from https://github.com/conda-forge/miniforge

```
cd ~/Downloads
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh
```

Then install using the "quiet" trick, so that there are no permanent mods to `.bashrc`:

```
 bash ~/Downloads/Miniforge3-Linux-aarch64.sh -b -s -p ~/.local/opt/miniforge3
 mkdir -p ~/.local/bin
 ln -s ~/.local/opt/miniforge3/condabin/conda ~/.local/bin/conda
```

Then you can enter the `(base)` Conda environment using `conda-setup` from `.bash_aliases`.

This keeps, for example, a clean separation between ROS 2 and Conda environments.

## Install ROS 2

Follow the instructions at https://github.com/danzimmerman/dz_rpi_config/wiki/installing_ros2#ros-2-jazzy-source-install to see some quirks and tweaks for Bookworm source install.

Don't modify `.bashrc` for sourcing the workspace `local_setup.bash` script. The `ros2-setup` command in `.bash_aliases` does this and also adds a `(jazzy)` to the ROS 2 prompt.

