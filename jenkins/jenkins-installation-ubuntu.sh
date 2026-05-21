#!/bin/bash

# ----------------------------------------
# JENKINS INSTALLATION ON UBUNTU
# ----------------------------------------

# Update packages
sudo apt update -y

# Install Java 17
sudo apt install -y openjdk-17-jdk

# Verify Java installation
java -version

# ----------------------------------------
# ADD JENKINS REPOSITORY
# ----------------------------------------

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
https://pkg.jenkins.io/debian-stable binary/ | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# ----------------------------------------
# INSTALL JENKINS
# ----------------------------------------

sudo apt update

sudo apt install jenkins -y

# ----------------------------------------
# START & ENABLE JENKINS
# ----------------------------------------

sudo systemctl start jenkins

sudo systemctl enable jenkins

# Verify Jenkins service status
sudo systemctl status jenkins

# Access Jenkins
# http://<PUBLIC-IP>:8080
