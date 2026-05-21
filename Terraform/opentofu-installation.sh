#!/bin/bash

# ----------------------------------------
# OPENTOFU INSTALLATION SETUP
# ----------------------------------------

# Download OpenTofu package
wget https://github.com/opentofu/opentofu/releases/download/v1.6.0-alpha3/tofu_1.6.0-alpha3_linux_amd64.zip

# Extract OpenTofu package
unzip tofu_1.6.0-alpha3_linux_amd64.zip

# Move OpenTofu binary to system path
sudo mv tofu /usr/local/bin/tofu

# Verify OpenTofu installation
tofu version
