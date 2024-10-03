# Raspberry Pi 5 Setup Repository

Semi-automatic setup of a Raspberry Pi with my desired bash additions, packages of interest, etc.

## Initial Setup

After cloning the repo into my home directory:

```
chmod +x ~/dz_rpi_config/install_apt_deps.sh
~/dz_rpi_config/install_apt_deps.sh
chmod +x ~/dz_rpi_config/set_up_bash_config.sh
~/dz_rpi_config/set_up_bash_config.sh
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
