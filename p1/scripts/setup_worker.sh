#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive
  
while [ ! -f /vagrant/shared/node-token ]; do
  sleep 2
done
  
NODE_TOKEN=$(cat /vagrant/shared/node-token)
  
apt-get update
apt-get install -y curl
  
K3S_URL="https://192.168.56.110:6443" K3S_TOKEN=$NODE_TOKEN sh -c 'curl -sfL https://get.k3s.io | sh -'
  
ln -s /usr/local/bin/k3s /usr/local/bin/kubectl || true
