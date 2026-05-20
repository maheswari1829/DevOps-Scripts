#!/bin/bash

# Download Loki configuration file
wget https://raw.githubusercontent.com/grafana/loki/v2.8.0/cmd/loki/loki-local-config.yaml \
-O loki-config.yaml

# Run Loki container
docker run -itd \
--name loki \
-v /root/:/mnt/config \
-p 3100:3100 \
grafana/loki:2.8.0

# Verify Loki
# http://<PUBLIC-IP>:3100/ready

# Download Promtail configuration file
wget https://raw.githubusercontent.com/grafana/loki/v2.8.0/clients/cmd/promtail/promtail-docker-config.yaml \
-O promtail-config.yaml

# Run Promtail container
docker run -itd \
--name promtail \
-v $(pwd):/mnt/config \
-v /var/log:/var/log \
--link loki \
grafana/promtail:2.8.0 \
--config.file=/mnt/config/promtail-config.yaml
