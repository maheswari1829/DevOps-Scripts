#!/bin/bash

# ----------------------------------------
# TERRAFORM INSTALLATION SETUP
# ----------------------------------------

# Install required packages
sudo yum install -y yum-utils shadow-utils

# Add HashiCorp repository
sudo yum-config-manager --add-repo \
https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

# Install Terraform
sudo yum install terraform -y

# Verify Terraform installation
terraform version

# Configure AWS CLI
aws configure
