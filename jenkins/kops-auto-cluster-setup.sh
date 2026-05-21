#!/bin/bash

# ----------------------------------------
# KOPS AUTO CLUSTER SETUP
# ----------------------------------------

# OPTIONAL PATH CONFIGURATION
# vim ~/.bashrc
# export PATH=$PATH:/usr/local/bin/
# source ~/.bashrc

# ----------------------------------------
# INSTALL AWS CLI
# ----------------------------------------

sudo apt update -y

sudo apt install unzip curl -y

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
-o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install

# Configure AWS CLI
aws configure

# ----------------------------------------
# INSTALL KUBECTL
# ----------------------------------------

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# ----------------------------------------
# INSTALL KOPS
# ----------------------------------------

wget https://github.com/kubernetes/kops/releases/download/v1.33.0/kops-linux-amd64

# Give executable permissions
chmod +x kops-linux-amd64 kubectl

# Move binaries to system path
sudo mv kubectl /usr/local/bin/kubectl

sudo mv kops-linux-amd64 /usr/local/bin/kops

# ----------------------------------------
# CREATE S3 BUCKET FOR KOPS STATE STORE
# ----------------------------------------

aws s3api create-bucket \
--bucket deploysscloudanddevopsbyraham007899123mnbvcxz.k8s.local \
--region us-east-1

# Enable bucket versioning
aws s3api put-bucket-versioning \
--bucket deploysscloudanddevopsbyraham007899123mnbvcxz.k8s.local \
--region us-east-1 \
--versioning-configuration Status=Enabled

# ----------------------------------------
# CONFIGURE KOPS STATE STORE
# ----------------------------------------

export KOPS_STATE_STORE=s3://deploysscloudanddevopsbyraham007899123mnbvcxz.k8s.local

# ----------------------------------------
# CREATE KUBERNETES CLUSTER
# ----------------------------------------

kops create cluster \
--name rahamss.k8s.local \
--zones us-east-1a \
--control-plane-image ami-0360c520857e3138f \
--control-plane-count=1 \
--control-plane-size t2.large \
--image ami-0360c520857e3138f \
--node-count=2 \
--node-size t2.medium

# ----------------------------------------
# APPLY CLUSTER CONFIGURATION
# ----------------------------------------

kops update cluster \
--name rahams.k8s.local \
--yes \
--admin

# ----------------------------------------
# VALIDATE CLUSTER
# ----------------------------------------

kops validate cluster --wait 10m

# Verify Kubernetes nodes
kubectl get nodes
