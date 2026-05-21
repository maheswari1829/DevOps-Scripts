#!/bin/bash

# ----------------------------------------
# WHATSAPP UI HOMEPAGE DEPLOYMENT
# ----------------------------------------

# Install Apache and Git
sudo yum install httpd git -y

# Start Apache service
sudo systemctl start httpd

# Verify Apache service status
sudo systemctl status httpd

# Enable Apache service on boot
sudo chkconfig httpd on

# Move to Apache web directory
cd /var/www/html

# Clone WhatsApp UI Homepage repository
sudo git clone https://github.com/hamsahmedansari/axiom-whatsapp-ui-homePage.git

# Move website files to Apache root directory
sudo mv axiom-whatsapp-ui-homePage/* .

# Verify Apache access logs
tail -100f /var/log/httpd/access_log

# Access Website
# http://<PUBLIC-IP>
