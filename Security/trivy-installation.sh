#!/bin/bash

# ----------------------------------------
# TRIVY INSTALLATION SETUP
# ----------------------------------------

# Download Trivy package
wget https://github.com/aquasecurity/trivy/releases/download/v0.72.0/trivy_0.72.0_Linux-64bit.tar.gz

# Extract Trivy package
tar -zxvf trivy_0.72.0_Linux-64bit.tar.gz

# Move Trivy binary to system path
sudo mv trivy /usr/local/bin/

# Configure PATH
echo "export PATH=\$PATH:/usr/local/bin/" >> ~/.bashrc

# Reload bash configuration
source ~/.bashrc

# Verify Trivy installation
trivy --version
