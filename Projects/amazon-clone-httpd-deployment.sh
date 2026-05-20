#!/bin/bash

# ----------------------------------------
# AMAZON CLONE DEPLOYMENT USING APACHE
# ----------------------------------------

# Install Apache and Git
sudo yum install httpd git -y

# Start Apache service
sudo systemctl start httpd

# Enable Apache service
sudo systemctl enable httpd

# Verify Apache service status
sudo systemctl status httpd

# Move to Apache web directory
cd /var/www/html

# Clone Amazon clone repository
sudo git clone https://github.com/Ironhack-Archive/online-clone-amazon.git

# Move website files to Apache root directory
sudo mv online-clone-amazon/* .

# Verify Apache access logs
tail -f /var/log/httpd/access_log

# Access Website
# http://<PUBLIC-IP>
