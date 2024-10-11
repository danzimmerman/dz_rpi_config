conda-setup(){
  eval "$(conda shell.bash hook)"
}
# https://answers.ros.org/question/292566/what-is-the-difference-between-local_setupbash-and-setupbash/
ros2-setup(){
  source ~/.local/opt/ros/jazzy_ws/install/local_setup.bash && PS1='(jazzy) ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
}
