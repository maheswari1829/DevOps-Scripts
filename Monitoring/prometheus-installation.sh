#!/bin/bash

# ----------------------------------------
# PROMETHEUS INSTALLATION SETUP
# ----------------------------------------

# Download Prometheus package
wget https://github.com/prometheus/prometheus/releases/download/v2.43.0/prometheus-2.43.0.linux-amd64.tar.gz

# Extract Prometheus package
tar -xf prometheus-2.43.0.linux-amd64.tar.gz

# Move Prometheus binaries
sudo mv prometheus-2.43.0.linux-amd64/prometheus \
prometheus-2.43.0.linux-amd64/promtool \
/usr/local/bin

# Create Prometheus directories
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

# Move console libraries
sudo mv prometheus-2.43.0.linux-amd64/console_libraries /etc/prometheus

# Verify Prometheus directory
ls /etc/prometheus

# Remove extracted files
sudo rm -rvf prometheus-2.43.0.linux-amd64*

# ----------------------------------------
# OPTIONAL: Configure Host Entries
# ----------------------------------------

# sudo vim /etc/hosts

# Example:
# 3.101.56.72 worker-1
# 54.193.223.22 worker-2

# ----------------------------------------
# CREATE PROMETHEUS CONFIGURATION
# ----------------------------------------

sudo cat <<EOF | sudo tee /etc/prometheus/prometheus.yml

global:
  scrape_interval: 10s

scrape_configs:
  - job_name: 'prometheus_metrics'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node_exporter_metrics'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9100','worker-1:9100','worker-2:9100']

EOF

# Create Prometheus user
sudo useradd -rs /bin/false prometheus

# Set permissions
sudo chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus

# Verify Prometheus permissions
sudo ls -l /etc/prometheus/

# ----------------------------------------
# CREATE SYSTEMD SERVICE
# ----------------------------------------

sudo cat <<EOF | sudo tee /etc/systemd/system/prometheus.service

[Unit]
Description=Prometheus
After=network.target

[Service]
User=prometheus
Group=prometheus
Type=simple

ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target

EOF

# Verify service file
sudo ls -l /etc/systemd/system/prometheus.service

# Reload systemd daemon
sudo systemctl daemon-reload

# Enable Prometheus service
sudo systemctl enable prometheus

# Start Prometheus service
sudo systemctl start prometheus

# Verify Prometheus service status
sudo systemctl status prometheus --no-pager

# Access Prometheus
# http://<PUBLIC-IP>:9090
