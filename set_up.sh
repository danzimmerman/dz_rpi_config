#!/bin/bash
# file to modify .bashrc to point at this repo

if [[ ! -f ~/.bashrc.original && -f ~/dz_rpi_config/bash_config/.bashrc_additions ]]; then
    echo "Making a read-only copy of ~/.bashrc to ~/.bashrc.original"
    cp ~/.bashrc ~/.bashrc.original
    sudo chmod a-w ~/.bashrc.original
    cat ~/dz_rpi_config/bash_config/.bashrc_mod_tail >> .bashrc
else
    echo "~/.bashrc.original backup copy already exists. Remove it if this is not expected."
fi

if [[ -d ~/dz_rpi_config && ! -f ~/.inputrc && ! -f ~/.bash_aliases ]]; then
  echo "~/dz_rpi_config exists but ~/.inputrc and ~/.bash_aliases do not, making softlinks..."
  ln -s ~/dz_rpi_config/bash_config/.bash_aliases ~/.bash_aliases
  ln -s ~/dz_rpi_config/bash_config/.inputrc ~/.inputrc
else
  echo "Attempting to softlink ~/.bash_aliases and ~/.inputrc but one of them was found. Remove them if this is not expected."
fi

echo "Copying eth0 netplan configuration to /etc/netplan"
sudo cp ~/dz_rpi_config/network/99-eth0-dhcp.yaml /etc/netplan
sudo chmod 600 /etc/netplan/99-eth0-dhcp.yaml
