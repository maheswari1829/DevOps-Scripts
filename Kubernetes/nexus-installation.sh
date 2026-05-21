#!/bin/bash

# ----------------------------------------
# NEXUS INSTALLATION SETUP
# ----------------------------------------

# Download Nexus package
wget https://download.sonatype.com/nexus/3/nexus-unix-x86-64-3.79.0-09.tar.gz

# Extract Nexus package
tar -zxvf nexus-unix-x86-64-3.79.0-09.tar.gz

# Install Java 17
sudo yum install java-17-amazon-corretto -y

# Create Nexus user
sudo useradd nexus

# Set ownership permissions
sudo chown -R nexus:nexus nexus-3.79.0-09

# Start Nexus service
sudo sh nexus-3.79.0-09/bin/nexus start

# Verify Nexus process
ps -ef | grep nexus

# Access Nexus Repository Manager
# http://<PUBLIC-IP>:8081
