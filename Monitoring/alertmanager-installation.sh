#!/bin/bash

set -e

# ----------------------------------------
# ALERTMANAGER INSTALLATION SETUP
# ----------------------------------------

# Variables
VERSION="0.18.0"
USER="alertmanager"
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="/etc/alertmanager"
DATA_DIR="/data/alertmanager"

# ----------------------------------------
# DOWNLOAD ALERTMANAGER
# ----------------------------------------

cd /tmp

wget https://github.com/prometheus/alertmanager/releases/download/v${VERSION}/alertmanager-${VERSION}.linux-amd64.tar.gz

# ----------------------------------------
# EXTRACT PACKAGE
# ----------------------------------------

tar -xvzf alertmanager-${VERSION}.linux-amd64.tar.gz

# ----------------------------------------
# MOVE BINARIES
# ----------------------------------------

sudo mv alertmanager-${VERSION}.linux-amd64/alertmanager ${INSTALL_DIR}/

sudo mv alertmanager-${VERSION}.linux-amd64/amtool ${INSTALL_DIR}/

# ----------------------------------------
# CREATE ALERTMANAGER USER
# ----------------------------------------

id -u ${USER} &>/dev/null || sudo useradd -rs /bin/false ${USER}

# ----------------------------------------
# CREATE DIRECTORIES
# ----------------------------------------

sudo mkdir -p ${CONFIG_DIR}

sudo mkdir -p ${DATA_DIR}

# ----------------------------------------
# CREATE ALERTMANAGER CONFIGURATION
# ----------------------------------------

sudo tee ${CONFIG_DIR}/alertmanager.yml > /dev/null <<EOF
global:
  resolve_timeout: 5m

route:
  receiver: "default"

receivers:
  - name: "default"
EOF

# ----------------------------------------
# SET PERMISSIONS
# ----------------------------------------

sudo chown -R ${USER}:${USER} ${CONFIG_DIR}

sudo chown -R ${USER}:${USER} ${DATA_DIR}

sudo chown ${USER}:${USER} \
${INSTALL_DIR}/alertmanager \
${INSTALL_DIR}/amtool

# ----------------------------------------
# REMOVE OLD SERVICE IF EXISTS
# ----------------------------------------

sudo systemctl stop alertmanager 2>/dev/null || true

sudo systemctl disable alertmanager 2>/dev/null || true

sudo systemctl unmask alertmanager 2>/dev/null || true

sudo rm -f /etc/systemd/system/alertmanager.service

sudo rm -f /lib/systemd/system/alertmanager.service

# ----------------------------------------
# CREATE SYSTEMD SERVICE
# ----------------------------------------

sudo tee /etc/systemd/system/alertmanager.service > /dev/null <<EOF

[Unit]
Description=Prometheus Alertmanager
Wants=network-online.target
After=network-online.target

[Service]
User=${USER}
Group=${USER}
Type=simple

ExecStart=${INSTALL_DIR}/alertmanager \
  --config.file=${CONFIG_DIR}/alertmanager.yml \
  --storage.path=${DATA_DIR}

Restart=always

[Install]
WantedBy=multi-user.target

EOF

# ----------------------------------------
# RELOAD SYSTEMD
# ----------------------------------------

sudo systemctl daemon-reexec

sudo systemctl daemon-reload

# ----------------------------------------
# ENABLE & START ALERTMANAGER
# ----------------------------------------

sudo systemctl enable alertmanager

sudo systemctl start alertmanager

# ----------------------------------------
# VERIFY ALERTMANAGER STATUS
# ----------------------------------------

sudo systemctl status alertmanager --no-pager

# Access Alertmanager UI
# http://<PUBLIC-IP>:9093
