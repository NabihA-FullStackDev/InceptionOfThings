#!/bin/bash

sudo apt update -y
sudo apt upgrade -y

sudo apt install -y \
    curl \
    wget \
    git \
    net-tools \
    sudo \
    build-essential \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    gnupg \
    lsb-release

if id "vagrant" &>/dev/null; then
    sudo usermod -aG sudo vagrant
fi

if ! command -v curl &>/dev/null; then
    sudo apt install -y curl
fi

if ! command -v git &>/dev/null; then
    sudo apt install -y git
fi

sudo apt autoremove -y
sudo apt clean

echo "done"