#!/bin/bash

# Update packages
sudo yum update -y

# Install Java 8
sudo yum install java-1.8.0-openjdk -y

# Install unzip utility
sudo yum install unzip -y

# Download JFrog Artifactory OSS
wget https://releases.jfrog.io/artifactory/bintray-artifactory/org/artifactory/oss/jfrog-artifactory-oss/6.9.6/jfrog-artifactory-oss-6.9.6.zip

# Extract package
unzip jfrog-artifactory-oss-6.9.6.zip

# Start Artifactory
sudo sh artifactory-oss-6.9.6/bin/artifactory.sh start
