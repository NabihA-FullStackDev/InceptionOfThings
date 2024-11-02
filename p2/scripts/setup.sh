#!/bin/bash

echo "Mise à jour du système et installation..."
sudo apt-get update -y
sudo apt-get install -y docker.io curl

echo "Installation de K3s en mode server..."
sudo curl -sfL https://get.k3s.io | sh -

echo "Activation de Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Chargement des images compressé sur la VM..."
sudo docker load -i /home/vagrant/app1.tar
sudo docker load -i /home/vagrant/app2.tar
sudo docker load -i /home/vagrant/app3.tar

echo "Construction des images Docker..."
sudo docker build -t app1:local /vagrant/docker/app1
sudo docker build -t app2:local /vagrant/docker/app2
sudo docker build -t app3:local /vagrant/docker/app3

echo "Chargement des images locales dans containerd..."
sudo k3s ctr images import /vagrant/app1.tar
sudo k3s ctr images import /vagrant/app2.tar
sudo k3s ctr images import /vagrant/app3.tar

echo "Déploiement des applications et de l'Ingress..."
kubectl apply -f /vagrant/confs/app1.yaml
kubectl apply -f /vagrant/confs/app2.yaml
kubectl apply -f /vagrant/confs/app3.yaml
kubectl apply -f /vagrant/confs/ingress.yaml

echo "Déploiement terminé."
