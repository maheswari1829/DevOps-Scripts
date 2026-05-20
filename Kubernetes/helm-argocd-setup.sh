#!/bin/bash

# ----------------------------------------
# HELM INSTALLATION SETUP
# ----------------------------------------

# Download Helm installation script
curl -fsSL -o get_helm.sh \
https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

# Give execute permissions
chmod 700 get_helm.sh

# Install Helm
./get_helm.sh

# Verify Helm installation
helm version

# ----------------------------------------
# INSTALL ARGOCD USING HELM
# ----------------------------------------

# Add ArgoCD Helm repository
helm repo add argo-cd https://argoproj.github.io/argo-helm

# Update Helm repositories
helm repo update

# Create ArgoCD namespace
kubectl create namespace argocd

# Install ArgoCD using Helm
helm install argocd argo-cd/argo-cd -n argocd

# Verify ArgoCD resources
kubectl get all -n argocd

# ----------------------------------------
# EXPOSE ARGOCD SERVER
# ----------------------------------------

# Change ArgoCD service type to LoadBalancer
kubectl patch svc argocd-server -n argocd \
-p '{"spec": {"type": "LoadBalancer"}}'

# Install jq utility
sudo yum install jq -y

# Get ArgoCD LoadBalancer hostname
export ARGOCD_SERVER=$(kubectl get svc argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname')

# Display ArgoCD hostname
echo $ARGOCD_SERVER

# Verify ArgoCD service hostname
kubectl get svc argocd-server -n argocd -o json | \
jq --raw-output '.status.loadBalancer.ingress[0].hostname'

# ----------------------------------------
# GET ARGOCD ADMIN PASSWORD
# ----------------------------------------

# Export ArgoCD password
export ARGO_PWD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

# Display ArgoCD password
echo $ARGO_PWD

# Verify ArgoCD password manually
kubectl -n argocd get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d

# Access ArgoCD
# http://<ARGOCD-LOADBALANCER-HOSTNAME>
