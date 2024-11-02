#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y curl
curl -sfL https://get.k3s.io | sh -
  
mkdir -p /vagrant/shared
cp /var/lib/rancher/k3s/server/node-token /vagrant/shared/node-token
  
ln -s /usr/local/bin/k3s /usr/local/bin/kubectl || true