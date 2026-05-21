#!/bin/bash

# ----------------------------------------
# DOCKER INSTALLATION ON UBUNTU
# ----------------------------------------

# Update system packages
sudo apt-get update

# Upgrade system packages
sudo apt-get upgrade -y

# Install Docker prerequisites
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
software-properties-common

# ----------------------------------------
# ADD DOCKER GPG KEY
# ----------------------------------------

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# ----------------------------------------
# ADD DOCKER REPOSITORY
# ----------------------------------------

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# ----------------------------------------
# INSTALL DOCKER
# ----------------------------------------

sudo apt-get update

sudo apt-get install -y \
docker-ce \
docker-ce-cli \
containerd.io

# ----------------------------------------
# START & ENABLE DOCKER
# ----------------------------------------

sudo systemctl start docker

sudo systemctl enable docker

# Verify Docker service
sudo systemctl status docker

# Verify Docker installation
docker --version
