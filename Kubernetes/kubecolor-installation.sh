#!/bin/bash

# Download kubecolor package
wget https://github.com/hidetatz/kubecolor/releases/download/v0.0.25/kubecolor_0.0.25_Linux_x86_64.tar.gz

# Extract kubecolor package
tar -zxvf kubecolor_0.0.25_Linux_x86_64.tar.gz

# Run kubecolor manually to understand usage
./kubecolor

# Give executable permissions
chmod +x kubecolor

# Move kubecolor binary to system path
sudo mv kubecolor /usr/local/bin/

# Verify kubecolor installation
kubecolor get po
