# Raspberry Pi 5 Setup Repository

Semi-automatic setup of a Raspberry Pi with my desired bash additions, packages of interest, etc.

## Initial Setup

After cloning the repo into my home directory:

```
chmod +x ~/dz_rpi_config/install_apt_deps.sh
~/dz_rpi_config/install_apt_deps.sh
chmod +x ~/dz_rpi_config/set_up.sh
~/dz_rpi_config/set_up.sh
```

After this, `~/.bashrc` will incorporate all the changes in `bash_config/.bashrc_additions` and `~/.bash_aliases` and `~/.inputrc` will be softlinks that point to their counterparts in this repo.

## dtoverlay Setup 

### CANBus

For CAN hat, see

https://www.waveshare.com/wiki/2-CH_CAN_HAT#For_64-bit_Raspberry_Pi_System

Add the following to `/boot/firmware/config.txt`:

```
dtoverlay=mcp2515-can1,oscillator=16000000,interrupt=25
dtoverlay=mcp2515-can0,oscillator=16000000,interrupt=23
dtoverlay=spi-bcm2835-overlay
```

## Network Setup

This copies the file `network/99-eth0-dhcp.yaml` to `/etc/netplan` and sets permissions.

## Install Conda

Download the latest `miniforge3` from https://github.com/conda-forge/miniforge

```
mkdir -p downloads
cd downloads
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh
```

Then install using the "quiet" trick, so that there are no permanent mods to `.bashrc`:

```
 bash ~/downloads/Miniforge3-Linux-aarch64.sh -b -s -p ~/.local/opt/miniforge3
 mkdir -p ~/.local/bin
 ln -s ~/.local/opt/miniforge3/condabin/conda ~/.local/bin/conda
```

Then you can enter the `(base)` Conda environment using `conda-setup` from `.bash_aliases`.

This keeps, for example, a clean separation between ROS 2 and Conda environments.

## Install ROS 2

Follow the instructions at https://docs.ros.org/en/jazzy/Installation/Ubuntu-Install-Debs.html but don't modify `.bashrc`. The `ros2-setup` command in `.bash_aliases` does this and also adds a `(jazzy)` to the ROS 2 prompt.

