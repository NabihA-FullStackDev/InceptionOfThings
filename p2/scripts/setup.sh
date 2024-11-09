#!/bin/bash

echo "Mise à jour du système et installation ...................."
sudo apt-get update -y
sudo apt-get install -y docker.io curl

echo "Installation de K3s en mode server ........................"
sudo curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig-mode 644 --flannel-iface=eth1" sh -

echo "Activation de Docker ......................................"
sudo systemctl enable docker
sudo systemctl start docker

echo "Chargement des images locales dans containerd ............."
sudo k3s ctr images import /vagrant/docker/app1/app1.tar
sudo k3s ctr images import /vagrant/docker/app2/app2.tar
sudo k3s ctr images import /vagrant/docker/app3/app3.tar

echo "Déploiement des applications et de l'Ingress .............."
kubectl apply -f /vagrant/confs/deploiements/app1_dep.yaml
kubectl apply -f /vagrant/confs/deploiements/app2_dep.yaml
kubectl apply -f /vagrant/confs/deploiements/app3_dep.yaml
kubectl apply -f /vagrant/confs/services/app1_svc.yaml
kubectl apply -f /vagrant/confs/services/app2_svc.yaml
kubectl apply -f /vagrant/confs/services/app3_svc.yaml
kubectl apply -f /vagrant/confs/ingress.yaml

echo ".......................................Déploiement terminé."
