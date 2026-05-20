#!/bin/bash

# ----------------------------------------
# AMAZON CLONE WEBSITE DEPLOYMENT
# ----------------------------------------

# Switch to root user
sudo -i

# Update packages
apt update -y

# Install Apache and Git
apt install apache2 git -y

# Clone Amazon clone project
git clone https://github.com/Ironhack-Archive/online-clone-amazon.git

# Move website files to Apache web directory
mv online-clone-amazon/* /var/www/html/

# Restart Apache service
systemctl restart apache2

# Verify Apache service status
systemctl status apache2

# Access Website
# http://<PUBLIC-IP>
