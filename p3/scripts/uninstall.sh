#!/bin/bash

echo "Désinstallation de K3d, Docker, Argo CD, et autres dépendances..."

if [[ $EUID -ne 0 ]]; then
   echo "Ce script doit être exécuté en tant que root" 
   exit 1
fi

echo "Suppression des namespaces Argo CD et dev..."
kubectl delete namespace argocd --ignore-not-found
kubectl delete namespace dev --ignore-not-found

echo "Suppression du cluster K3d..."
k3d cluster delete mycluster

echo "Suppression de K3d..."
rm -f /usr/local/bin/k3d

echo "Suppression de kubectl..."
rm -f /usr/local/bin/kubectl

echo "Arrêt de Docker..."
systemctl stop docker
systemctl disable docker

echo "Désinstallation de Docker et de ses dépendances..."
apt remove --purge -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "Suppression des dépendances pour Docker..."
apt remove --purge -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release

echo "Nettoyage des fichiers et des images Docker..."
rm -rf /var/lib/docker
rm -rf /var/lib/containerd
rm -rf /etc/docker
rm -f /usr/share/keyrings/docker-archive-keyring.gpg

echo "Nettoyage des paquets inutilisés et mise à jour de la liste des paquets..."
apt autoremove -y
apt update

echo "Désinstallation complète effectuée avec succès."
