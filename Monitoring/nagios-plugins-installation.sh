#!/bin/bash

# ----------------------------------------
# NAGIOS PLUGINS INSTALLATION SETUP
# ----------------------------------------

# Set Nagios Plugins version
VER="2.3.3"

# ----------------------------------------
# DOWNLOAD NAGIOS PLUGINS
# ----------------------------------------

curl -SL \
https://github.com/nagios-plugins/nagios-plugins/releases/download/release-$VER/nagios-plugins-$VER.tar.gz \
| tar -xzf -

# Move to extracted directory
cd nagios-plugins-2.3.3/

# ----------------------------------------
# COMPILE & INSTALL NAGIOS PLUGINS
# ----------------------------------------

./configure

make install

# ----------------------------------------
# CREATE NAGIOS WEB USER
# ----------------------------------------

# Create nagiosadmin account for web login
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

# Restart Apache service
sudo service apache2 restart

# ----------------------------------------
# VERIFY NAGIOS CONFIGURATION
# ----------------------------------------

sudo /usr/local/nagios/bin/nagios \
-v /usr/local/nagios/etc/nagios.cfg

# ----------------------------------------
# ENABLE & START NAGIOS
# ----------------------------------------

sudo systemctl enable --now nagios

# Verify Nagios service status
sudo systemctl status nagios

# Access Nagios Web UI
# http://<PUBLIC-IP>/nagios
