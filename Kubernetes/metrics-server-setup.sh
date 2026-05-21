#!/bin/bash

# ----------------------------------------
# METRICS SERVER SETUP
# ----------------------------------------

# Metrics Server is used to collect:
# - CPU usage
# - Memory usage
# from Kubernetes nodes and pods.

# ----------------------------------------
# INSTALL METRICS SERVER
# ----------------------------------------

kubectl apply -f \
https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# ----------------------------------------
# ENABLE METRICS SERVER FOR MINIKUBE
# ----------------------------------------

# Only for Minikube
minikube addons enable metrics-server

# ----------------------------------------
# VERIFY NODE METRICS
# ----------------------------------------

kubectl top nodes

# ----------------------------------------
# VERIFY POD METRICS
# ----------------------------------------

kubectl top pods

# ----------------------------------------
# FOR KOPS CLUSTER
# ----------------------------------------

# Install High Availability Metrics Server
kubectl apply -f \
https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/high-availability-1.21+.yaml
