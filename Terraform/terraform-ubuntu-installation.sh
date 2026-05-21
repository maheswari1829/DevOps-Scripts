#!/bin/bash

# ----------------------------------------
# TERRAFORM INSTALLATION ON UBUNTU
# ----------------------------------------

# Update packages
sudo apt update -y

# Download HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add HashiCorp repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com \
$(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update package index
sudo apt update

# Install Terraform
sudo apt install terraform -y

# Verify Terraform installation
terraform version

# Install AWS CLI
sudo apt install awscli -y

# Configure AWS CLI
aws configure
