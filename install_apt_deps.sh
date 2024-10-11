#!/bin/bash
sudo apt update
sudo apt install \
  tmux \
  stress \
  gh \
  python3-rpi.gpio \
  python3-gpiozero \
  iftop \
  nload \
  iperf3 \
  chrony \
  can-utils \
  python3-rosdep \
  python3-vcstool \
  ros-dev-tools
  -y
