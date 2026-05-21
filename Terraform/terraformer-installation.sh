#!/bin/bash

# ----------------------------------------
# TERRAFORMER INSTALLATION SETUP
# ----------------------------------------

# Download Terraformer binary
wget https://github.com/GoogleCloudPlatform/terraformer/releases/download/0.8.24/terraformer-all-linux-amd64

# Give executable permissions
chmod +x terraformer-all-linux-amd64

# Move Terraformer binary to system path
sudo mv terraformer-all-linux-amd64 /usr/local/bin/terraformer

# Verify Terraformer installation
terraformer --version

# ----------------------------------------
# TERRAFORMER IMPORT COMMAND
# ----------------------------------------

# Import AWS resources
terraformer import aws \
--resources=sg,ec2_instance,elb \
--regions=us-east-1

# ----------------------------------------
# UPDATE PROVIDERS IN STATE FILE
# ----------------------------------------

terraform state replace-provider -- -/aws hashicorp/aws

# Initialize Terraform
terraform init

# Verify Terraform execution plan
terraform plan

# Apply Terraform changes
terraform apply
