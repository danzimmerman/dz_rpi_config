conda-setup(){
  eval "$(conda shell.bash hook)"
}
ros2-setup(){
  source /opt/ros/jazzy/setup.bash && PS1='(jazzy) ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
}