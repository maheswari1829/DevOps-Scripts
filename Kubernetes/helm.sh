#!/bin/bash

# ----------------------------------------
# HELM INSTALLATION SETUP
# ----------------------------------------

# Download Helm installation script
curl -fsSL -o get_helm.sh \
https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

# Give execute permissions
chmod 700 get_helm.sh

# Run Helm installation script
./get_helm.sh

# Verify Helm installation
helm version
