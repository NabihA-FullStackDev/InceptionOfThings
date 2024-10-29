#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y curl gnupg lsb-release apt-transport-https ca-certificates openssh-server

sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

export K3S_URL="https://192.168.56.110:6443"
export K3S_TOKEN="mysecrettoken"
export INSTALL_K3S_VERSION="v1.27.4+k3s1"
curl -sfL https://get.k3s.io | sudo sh -s - agent

sudo curl -Lo /usr/local/bin/kubectl https://dl.k8s.io/release/v1.27.4/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl
