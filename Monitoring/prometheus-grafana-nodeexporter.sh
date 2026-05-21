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
sudo mkdir /etc/prometheus /var/lib/prometheus

# Move console libraries
sudo mv prometheus-2.43.0.linux-amd64/console_libraries /etc/prometheus

# Verify Prometheus directory
ls /etc/prometheus

# Remove extracted files
sudo rm -rvf prometheus-2.43.0.linux-amd64*

# ----------------------------------------
# OPTIONAL HOST CONFIGURATION
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
  - job_name: 'metrics'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']

EOF

# Create Prometheus user
sudo useradd -rs /bin/false prometheus

# Set permissions
sudo chown -R prometheus: /etc/prometheus /var/lib/prometheus

# Verify permissions
sudo ls -l /etc/prometheus/

# ----------------------------------------
# CREATE PROMETHEUS SYSTEMD SERVICE
# ----------------------------------------

sudo cat <<EOF | tee /etc/systemd/system/prometheus.service

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

# Verify Prometheus service file
sudo ls -l /etc/systemd/system/prometheus.service

# Reload systemd daemon
sudo systemctl daemon-reload

# Enable Prometheus service
sudo systemctl enable prometheus

# Start Prometheus service
sudo systemctl start prometheus

# Verify Prometheus service
sudo systemctl status prometheus --no-pager

# Access Prometheus
# http://<PUBLIC-IP>:9090

# ----------------------------------------
# GRAFANA INSTALLATION SETUP
# ----------------------------------------

# Install dependencies
sudo apt-get install -y adduser libfontconfig1

# Download Grafana package
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_9.4.7_amd64.deb

# Install Grafana
sudo dpkg -i grafana-enterprise_9.4.7_amd64.deb

# Reload systemd daemon
sudo systemctl daemon-reload

# Enable Grafana service
sudo systemctl enable grafana-server

# Start Grafana service
sudo systemctl start grafana-server

# Verify Grafana service
sudo systemctl status grafana-server --no-pager

# Access Grafana
# http://<PUBLIC-IP>:3000

# ----------------------------------------
# NODE EXPORTER INSTALLATION SETUP
# ----------------------------------------

# Download Node Exporter package
wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz

# Extract Node Exporter package
tar -xf node_exporter-1.5.0.linux-amd64.tar.gz

# Move Node Exporter binary
sudo mv node_exporter-1.5.0.linux-amd64/node_exporter /usr/local/bin

# Remove extracted files
rm -rv node_exporter-1.5.0.linux-amd64*

# Create Node Exporter user
sudo useradd -rs /bin/false node_exporter

# ----------------------------------------
# CREATE NODE EXPORTER SYSTEMD SERVICE
# ----------------------------------------

sudo cat <<EOF | sudo tee /etc/systemd/system/node_exporter.service

[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple

ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target

EOF

# Verify Node Exporter service file
sudo cat /etc/systemd/system/node_exporter.service

# Reload systemd daemon
sudo systemctl daemon-reload

# Enable Node Exporter service
sudo systemctl enable node_exporter

# Start Node Exporter service
sudo systemctl start node_exporter.service

# Verify Node Exporter service
sudo systemctl status node_exporter.service --no-pager

# Access Node Exporter Metrics
# http://<PUBLIC-IP>:9100/metrics
