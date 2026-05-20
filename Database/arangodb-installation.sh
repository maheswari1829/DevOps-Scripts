#!/bin/bash

# ----------------------------------------
# ARANGODB INSTALLATION SETUP
# ----------------------------------------

# Add ArangoDB repository
echo 'deb https://download.arangodb.com/arangodb34/DEBIAN/ /' | \
sudo tee /etc/apt/sources.list.d/arangodb.list

# Add ArangoDB GPG key
wget -q https://download.arangodb.com/arangodb34/DEBIAN/Release.key -O- | \
sudo apt-key add -

# Update packages
sudo apt update -y

# Install HTTPS transport package
sudo apt install apt-transport-https -y

# Install ArangoDB
sudo apt install arangodb3 -y

# Start ArangoDB service
sudo systemctl start arangodb3

# Enable ArangoDB service
sudo systemctl enable arangodb3

# Verify ArangoDB service status
sudo systemctl status arangodb3

# Access ArangoDB shell
sudo arangosh

# Access ArangoDB Web UI
# http://<PUBLIC-IP>:8529
