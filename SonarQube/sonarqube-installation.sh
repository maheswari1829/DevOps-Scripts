#!/bin/bash

# Install Java 11
sudo amazon-linux-extras install java-openjdk11 -y

# Move to opt directory
cd /opt/

# Download SonarQube package
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.6.50800.zip

# Install unzip utility
sudo yum install unzip -y

# Extract SonarQube package
sudo unzip sonarqube-8.9.6.50800.zip

# Create sonar user
sudo useradd sonar

# Change ownership
sudo chown -R sonar:sonar sonarqube-8.9.6.50800

# Set permissions
sudo chmod -R 775 sonarqube-8.9.6.50800

# Switch to sonar user
sudo su - sonar

# Start SonarQube manually
# sh /opt/sonarqube-8.9.6.50800/bin/linux-x86-64/sonar.sh start

# Default credentials
# username: admin
# password: admin
