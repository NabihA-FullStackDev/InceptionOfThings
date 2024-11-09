#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y curl net-tools

sleep 30

NODE_TOKEN=$(cat /vagrant/shared/node-token)
curl -sfL https://get.k3s.io | K3S_URL="https://192.168.56.110:6443" INSTALL_K3S_EXEC="--node-ip=192.168.56.111" K3S_TOKEN="${NODE_TOKEN}" sh -

# install net-tools
# /sbin/ifconfig eth1
