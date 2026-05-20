#!/bin/bash

# ----------------------------------------
# MYSQL INSTALLATION SETUP
# ----------------------------------------

# Download MySQL repository package
sudo wget https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm

# Install MySQL repository
sudo dnf install mysql80-community-release-el9-1.noarch.rpm -y

# Import MySQL GPG key
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023

# Install MySQL client
sudo dnf install mysql-community-client -y

# Install MySQL server
sudo dnf install mysql-community-server -y

# Enable MySQL service
sudo systemctl enable mysqld

# Start MySQL service
sudo systemctl start mysqld

# Verify MySQL service status
sudo systemctl status mysqld

# Get temporary MySQL root password
sudo grep 'temporary password' /var/log/mysqld.log

# Access MySQL
# mysql -u root -p
