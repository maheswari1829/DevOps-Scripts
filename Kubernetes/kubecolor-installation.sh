#!/bin/bash

# Download kubecolor package
wget https://github.com/hidetatz/kubecolor/releases/download/v0.0.25/kubecolor_0.0.25_Linux_x86_64.tar.gz

# Extract package
tar -zxvf kubecolor_0.0.25_Linux_x86_64.tar.gz

# Give executable permission
chmod +x kubecolor

# Move binary to system path
sudo mv kubecolor /usr/local/bin/

# Verify kubecolor installation
kubecolor get po
