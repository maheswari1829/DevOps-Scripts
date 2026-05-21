#!/bin/bash

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
# CREATE SYSTEMD SERVICE
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

# Verify service file
sudo cat /etc/systemd/system/node_exporter.service

# Reload systemd daemon
sudo systemctl daemon-reload

# Enable Node Exporter service
sudo systemctl enable node_exporter

# Start Node Exporter service
sudo systemctl start node_exporter.service

# Verify Node Exporter service status
sudo systemctl status node_exporter.service --no-pager

# Access Node Exporter Metrics
# http://<PUBLIC-IP>:9100/metrics
