#!/bin/bash

# Install Java 17
sudo yum install java-21-amazon-corretto -y

# Download Nexus package
wget https://download.sonatype.com/nexus/3/nexus-unix-x86-64-3.79.0-09.tar.gz

# Extract Nexus package
tar -zxvf nexus-unix-x86-64-3.79.0-09.tar.gz

# Create Nexus user
sudo useradd nexus

# Change ownership
sudo chown -R nexus:nexus nexus-3.79.0-09

# Start Nexus
sudo sh nexus-3.79.0-09/bin/nexus start
