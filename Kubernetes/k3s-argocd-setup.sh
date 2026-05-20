#!/bin/bash

# ----------------------------------------
# K3S + ARGOCD SETUP
# ----------------------------------------

# Update packages
sudo apt update && sudo apt upgrade -y

# Install required packages
sudo apt install -y \
curl \
wget \
git \
apt-transport-https \
ca-certificates \
gnupg \
lsb-release

# Disable swap
sudo swapoff -a

# Remove swap entry from fstab
sudo sed -i '/swap/d' /etc/fstab

# ----------------------------------------
# INSTALL K3S
# ----------------------------------------

curl -sfL https://get.k3s.io | sh -

# Verify Kubernetes nodes
sudo kubectl get nodes

# Configure kubeconfig
mkdir -p ~/.kube

sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config

sudo chown $USER:$USER ~/.kube/config

# Verify Kubernetes pods
kubectl get pods -A

# Wait for cluster initialization
sleep 10

# ----------------------------------------
# INSTALL ARGOCD
# ----------------------------------------

# Create ArgoCD namespace
kubectl create namespace argocd

# Install ArgoCD
kubectl apply -n argocd \
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Verify ArgoCD pods
kubectl get pods -n argocd

# Expose ArgoCD service using NodePort
kubectl patch svc argocd-server -n argocd \
-p '{"spec": {"type": "NodePort"}}'

# Verify ArgoCD service
kubectl get svc argocd-server -n argocd

# Access ArgoCD
# http://<PUBLIC-IP>:<NODEPORT>
