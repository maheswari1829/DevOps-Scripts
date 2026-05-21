#!/bin/bash

# ----------------------------------------
# AWS CLI INSTALLATION SETUP
# ----------------------------------------

# Download AWS CLI package
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
-o "awscliv2.zip"

# Install required packages
sudo apt install unzip curl -y

# Extract AWS CLI package
unzip awscliv2.zip

# Install AWS CLI
sudo ./aws/install

# Verify AWS CLI installation
aws --version

# Configure AWS CLI
aws configure
