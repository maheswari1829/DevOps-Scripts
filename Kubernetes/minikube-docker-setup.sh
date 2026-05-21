#!/bin/bash

# ----------------------------------------
# MINIKUBE + DOCKER + KUBECTL SETUP
# ----------------------------------------

# Update packages
sudo apt update -y

# Upgrade packages
sudo apt upgrade -y

# Install required packages
sudo apt install curl wget apt-transport-https -y

# ----------------------------------------
# INSTALL DOCKER
# ----------------------------------------

sudo curl -fsSL https://get.docker.com -o get-docker.sh

sudo sh get-docker.sh

# Verify Docker installation
docker --version

# ----------------------------------------
# INSTALL MINIKUBE
# ----------------------------------------

sudo curl -LO \
https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo mv minikube-linux-amd64 /usr/local/bin/minikube

sudo chmod +x /usr/local/bin/minikube

# Verify Minikube installation
sudo minikube version

# ----------------------------------------
# INSTALL KUBECTL
# ----------------------------------------

sudo curl -LO \
"https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Download checksum file
sudo curl -LO \
"https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

# Verify kubectl checksum
sudo echo "$(cat kubectl.sha256) kubectl" | sha256sum --check

# Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Verify kubectl installation
kubectl version --client

# ----------------------------------------
# START MINIKUBE
# ----------------------------------------

sudo minikube start --driver=docker --force

# Verify Minikube status
minikube status

# Verify Kubernetes nodes
kubectl get nodes
