#!/bin/bash

# Add kubectl path manually if required
# vim ~/.bashrc
# export PATH=$PATH:/usr/local/bin
# source ~/.bashrc

# Install Docker
sudo yum install docker -y

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Verify Docker status
sudo systemctl status docker

# Download kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Move kubectl binary
sudo mv kubectl /usr/local/bin/kubectl

# Give execute permission
sudo chmod +x /usr/local/bin/kubectl

# Download Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Install Minikube
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Install dependencies
sudo yum install iptables -y
sudo yum install conntrack -y

# Start Minikube using Docker driver
minikube start --driver=docker --force

# Verify Minikube status
minikube status
