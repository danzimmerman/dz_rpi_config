alias cdros="cd ~/ros2ws"
alias cdsrc="cd ~/.local/opt/ros/jazzy_ws"
alias cdext="cd ~/.local/opt/ros/jazzy_extras_ws"
alias clean-ros-logs="rm -r ~/.ros/log/*"
can-init(){
  for iface in can0 can1; do 
    echo Taking $iface down and back up.
    sudo ip link set $iface down
    sudo ip link set $iface up type can bitrate 1000000
    sudo ip link set $iface txqueuelen 1000
    sudo ip link set $iface up
  done
}
conda-setup(){
  eval "$(conda shell.bash hook)"
}
# https://answers.ros.org/question/292566/what-is-the-difference-between-local_setupbash-and-setupbash/
ros2-base(){
  source ~/.local/opt/ros/jazzy_extras_ws/install/setup.bash && PS1='(jazzy) ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$' 
}
ros2-setup(){
  ros2-base && source ~/ros2ws/install/local_setup.bash
}
alias rpi-temp="vcgencmd measure_temp && vcgencmd get_throttled"
alias dubig="du -h | sort -h -k1 -r"
