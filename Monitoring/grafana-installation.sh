#!/bin/bash

# ----------------------------------------
# GRAFANA INSTALLATION SETUP
# ----------------------------------------

# Install required dependencies
sudo apt-get install -y adduser libfontconfig1

# Download Grafana Enterprise package
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_9.4.7_amd64.deb

# Install Grafana package
sudo dpkg -i grafana-enterprise_9.4.7_amd64.deb

# Reload systemd daemon
sudo systemctl daemon-reload

# Enable Grafana service
sudo systemctl enable grafana-server

# Start Grafana service
sudo systemctl start grafana-server

# Verify Grafana service status
sudo systemctl status grafana-server --no-pager

# Access Grafana
# http://<PUBLIC-IP>:3000

# Default Credentials
# Username: admin
# Password: admin
