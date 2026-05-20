#!/bin/bash

# Configure AWS CLI
aws configure

# Download kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Download KOPS
wget https://github.com/kubernetes/kops/releases/download/v1.33.0/kops-linux-amd64

# Give executable permissions
chmod +x kops-linux-amd64 kubectl

# Move binaries
sudo mv kubectl /usr/local/bin/kubectl
sudo mv kops-linux-amd64 /usr/local/bin/kops

# Configure PATH
echo 'export PATH=$PATH:/usr/local/bin/' >> ~/.bashrc
source ~/.bashrc

# Configure KOPS state store
export KOPS_STATE_STORE=s3://<your-bucket-name>.k8s.local

# Create Kubernetes cluster
kops create cluster \
--name devops.k8s.local \
--zones ap-south-1a \
--control-plane-image ami-xxxxxxxx \
--control-plane-count=1 \
--control-plane-size c7i-flex.large \
--image ami-xxxxxxxx \
--node-count=2 \
--node-size c7i-flex.large

# Apply cluster configuration
kops update cluster --name devops.k8s.local --yes --admin
