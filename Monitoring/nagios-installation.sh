#!/bin/bash

# ----------------------------------------
# NAGIOS CORE INSTALLATION SETUP
# ----------------------------------------

# Install prerequisites
sudo apt install wget unzip vim curl gcc openssl \
build-essential libgd-dev libssl-dev \
libapache2-mod-php php-gd php apache2 -y

# ----------------------------------------
# INSTALL NAGIOS CORE
# ----------------------------------------

# Set Nagios version
export VER="4.4.6"

# Download and extract Nagios package
curl -SL \
https://github.com/NagiosEnterprises/nagioscore/releases/download/nagios-$VER/nagios-$VER.tar.gz \
| tar -xzf -

# Move to Nagios directory
cd /root/nagios-4.4.6/

# ----------------------------------------
# COMPILE NAGIOS
# ----------------------------------------

./configure

make all

# ----------------------------------------
# CREATE USERS & GROUPS
# ----------------------------------------

make install-groups-users

sudo usermod -a -G nagios nagios

# ----------------------------------------
# INSTALL NAGIOS
# ----------------------------------------

make install

make install-init

make install-config

make install-commandmode

make install-webconf

# ----------------------------------------
# ENABLE APACHE MODULES
# ----------------------------------------

sudo a2enmod rewrite cgi

# Restart Apache
sudo systemctl restart apache2

# ----------------------------------------
# INSTALL NAGIOS THEMES
# ----------------------------------------

make install-exfoliation

make install-classicui

# ----------------------------------------
# VERIFY NAGIOS STATUS
# ----------------------------------------

sudo systemctl status nagios

# Access Nagios UI
# http://<PUBLIC-IP>/nagios
