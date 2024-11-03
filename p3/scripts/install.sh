#!/bin/bash

echo "Mise à jour des paquets ................................................."
sudo apt update && sudo apt upgrade -y

echo "Installation des dépendances pour Docker ................................"
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release

echo "Ajout de la clé GPG de Docker..."
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "Ajout du dépôt Docker ..................................................."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Installation de Docker .................................................."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

echo "Démarrage de Docker ....................................................."
sudo systemctl start docker
sudo systemctl enable docker

if ! sudo docker run hello-world > /dev/null 2>&1; then
    echo "Docker n'a pas pu être installé correctement. Vérifiez les erreurs ci-dessus."
    exit 1
else
    echo "Docker est installé et fonctionne correctement."
fi

echo "Installation de K3d ...................................................."
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

echo "Création du cluster K3d ................................................"
k3d cluster create mycluster --api-port 6550 -p "8080:80@loadbalancer" -p "8888:8888@loadbalancer" --agents 2

echo "Installation de kubectl ................................................"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

echo "Configuration de kubectl pour le cluster K3d ..........................."
export KUBECONFIG=$(k3d kubeconfig write mycluster)

kubectl get nodes

echo "Installation d'Argo CD ................................................."
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Exposition d'Argo CD ..................................................."
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

echo "Création du namespace 'dev' ............................................"
kubectl create namespace dev

echo "Attente du démarrage d'Argo CD (environ 5 minutes) ....................."
sleep 300  # Adapter si nécessaire

kubectl apply -f argo-application.yaml -n argocd

echo "Mot de passe initial d'Argo CD (utilisateur : admin) -> dans mdpArgoCD"
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d > mdpArgoCD
echo

# Affichage des informations
echo "Installation terminée. Accédez à Argo CD via http://localhost:8080"
echo "Pour utiliser kubectl, assurez-vous que la variable KUBECONFIG est définie comme suit :"
echo "export KUBECONFIG=$(k3d kubeconfig write mycluster)"
