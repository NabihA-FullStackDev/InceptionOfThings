#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y curl

sleep 30

NODE_TOKEN=$(cat /vagrant/shared/node-token)
curl -sfL https://get.k3s.io | K3S_URL="https://192.168.56.110:6443" K3S_TOKEN="${NODE_TOKEN}" sh -
