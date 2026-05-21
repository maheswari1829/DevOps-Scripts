#!/bin/bash

# ----------------------------------------
# PERCONA SERVER INSTALLATION SETUP
# ----------------------------------------

# Download Percona repository package
wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb

# Install Percona repository
sudo dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb

# Enable Percona Server 8.0 repository
sudo percona-release setup ps80

# Install Percona Server
sudo apt install percona-server-server -y

# Start MySQL service
sudo systemctl start mysql

# Enable MySQL service
sudo systemctl enable mysql

# Verify MySQL service status
sudo systemctl status mysql

# Access Percona MySQL Server
mysql -u root -p

# Verify MySQL version
mysql --version
