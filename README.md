# Raspberry Pi 5 Setup Repository

Semi-automatic setup of a Raspberry Pi with my desired bash additions, packages of interest, etc.

## Setup

After cloning the repo into my home directory:

```
chmod +x ~/dz_rpi_config/install_apt_deps.sh
~/dz_rpi_config/install_apt_deps.sh
chmod +x ~/dz_rpi_config/set_up_bash_config.sh
~/dz_rpi_config/set_up_bash_config.sh
```

After this, `~/.bashrc` will incorporate all the changes in `bash_config/.bashrc_additions` and `~/.bash_aliases` and `~/.inputrc` will be softlinks that point to their counterparts in this repo.