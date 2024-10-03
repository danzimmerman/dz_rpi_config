# file to modify .bashrc to point at this repo

if [ ! -f ~/.bashrc.original ]; then
    cp ~/.bashrc ~/.bashrc.original
    sudo chmod a-w ~/.bashrc.original
fi
