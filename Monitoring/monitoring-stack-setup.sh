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

# Download Grafana GPG key
wget -q -O gpg.key https://rpm.grafana.com/gpg.key

# Import GPG key
sudo rpm --import gpg.key

# Create Grafana repository
sudo cat <<EOF | tee /etc/yum.repos.d/grafana.repo

[grafana]
name=grafana
baseurl=https://rpm.grafana.com
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://rpm.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt

EOF

# Exclude beta versions
exclude=*beta*

# Install Grafana
sudo yum install grafana -y

# Start Grafana service
sudo systemctl start grafana-server.service

# Verify Grafana service
sudo systemctl status grafana-server.service

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
