# Inception of Things (IoT)

Dans ce projet, j’ai mis en place et configuré plusieurs environnements pour me familiariser avec Kubernetes en utilisant K3s et K3d. 

Je me suis concentré sur les bases des déploiements et la gestion d’applications dans des environnements virtuels. 
Le projet est divisé en trois parties principales.

## P1 : Mise en place de K3s avec Vagrant
Pour commencer, j’ai configuré deux machines virtuelles avec Vagrant en utilisant une distribution Linux minimale pour optimiser les ressources.

J’ai écrit un fichier Vagrantfile qui configure :
- **Un serveur principal (Server)** : en mode contrôleur avec K3s.
- **Un serveur de travail (ServerWorker)** : en mode agent, connecté au contrôleur.

J’ai également configuré une connexion SSH sans mot de passe entre les machines et installé `kubectl` pour pouvoir gérer et administrer K3s. 

Cette étape m’a permis de comprendre comment mettre en place un cluster Kubernetes de base et de m’assurer qu'il fonctionne correctement dans un environnement virtuel.

## P2 : Déploiement de trois applications simples avec K3s
Ensuite, j’ai continué avec K3s en déployant trois applications web sur une seule machine virtuelle configurée en mode serveur.
J'ai paramétré un système où chaque application est accessible selon le nom d’hôte utilisé dans la requête HTTP (par exemple, app1.com, app2.com).
L'une des applications dispose de trois répliques pour simuler une configuration plus robuste.

Cette partie m'a permis de mieux comprendre comment gérer plusieurs applications dans un même cluster et de pratiquer la gestion des Ingress pour contrôler l’accès aux applications.

## P3 : Déploiement continu avec K3d et Argo CD
Pour finir, j’ai découvert K3d et configuré un système de déploiement continu avec Argo CD. J’ai installé K3d, qui m’a permis de simuler un cluster Kubernetes avec Docker, et j’ai mis en place un dépôt GitHub pour automatiser les déploiements d’une application. En utilisant deux versions de cette application, j’ai pu configurer Argo CD pour détecter et déployer automatiquement les mises à jour depuis le dépôt Git.

Cela m’a permis d’appréhender les bases de l’intégration continue et de voir comment les mises à jour peuvent être propagées automatiquement dans un environnement Kubernetes.

---

Ce projet m'a donné une bonne introduction aux concepts de Kubernetes, en partant de la configuration de base jusqu'à la mise en place d'un déploiement continu. Chaque étape m'a permis de renforcer mes compétences en administration de systèmes et en gestion d’applications dans un cluster.