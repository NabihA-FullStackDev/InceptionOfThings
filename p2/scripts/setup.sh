#!/bin/bash

echo "Mise à jour du système et installation..."
sudo apt-get update -y
sudo apt-get install -y docker.io curl

echo "Installation de K3s en mode server..."
sudo curl -sfL https://get.k3s.io | sh -

echo "Activation de Docker..."
sudo systemctl enable docker
sudo systemctl start docker

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
