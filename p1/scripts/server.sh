#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y curl gnupg lsb-release apt-transport-https ca-certificates openssh-client sshpass

sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

export INSTALL_K3S_VERSION="v1.27.4+k3s1"
export INSTALL_K3S_TOKEN="mysecrettoken"
curl -sfL https://get.k3s.io | sudo sh -

mkdir -p /home/vagrant/.kube
sudo cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
sudo chown vagrant:vagrant /home/vagrant/.kube/config

sudo curl -Lo /usr/local/bin/kubectl https://dl.k8s.io/release/v1.27.4/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl

sudo -u vagrant ssh-keygen -t rsa -b 4096 -f /home/vagrant/.ssh/id_rsa -N ""
sudo -u vagrant sshpass -p "vagrant" ssh-copy-id -o StrictHostKeyChecking=no vagrant@192.168.56.111
