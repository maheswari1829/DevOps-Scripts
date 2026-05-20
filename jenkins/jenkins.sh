#!/bin/bash

# Update packages
sudo yum update -y

# Add Jenkins repository
sudo wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import Jenkins key
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Upgrade packages
sudo yum upgrade -y

# Install Java 21
sudo yum install java-21-amazon-corretto -y

# Install Jenkins, Git, and Maven
sudo yum install jenkins git maven -y

# Enable and start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Check Jenkins status
sudo systemctl status jenkins

# Fix Jenkins temporary directory issue
sudo mkdir -p /var/tmp_disk
sudo chmod 1777 /var/tmp_disk

# Mount custom tmp directory
sudo mount --bind /var/tmp_disk /tmp

# Persist mount after reboot
echo '/var/tmp_disk /tmp none bind 0 0' | sudo tee -a /etc/fstab

# Mask default tmp mount
sudo systemctl mask tmp.mount

# Verify tmp disk usage
df -h /tmp

# Restart Jenkins
sudo systemctl restart jenkins

# Configure Java environment variables
echo "export JAVA_HOME=/usr/lib/jvm/java-21-amazon-corretto" >> ~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc

# Apply environment changes
source ~/.bashrc

# Verify Java and Maven versions
java -version
mvn -version
