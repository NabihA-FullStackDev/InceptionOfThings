#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y curl

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig-mode 644 --flannel-iface=eth1" sh -

mkdir -p /vagrant/shared
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/shared/
sudo chmod 644 /vagrant/shared/node-token
