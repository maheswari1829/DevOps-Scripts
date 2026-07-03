#!/bin/bash

# Download Docker Compose binary
sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o docker-compose

# Check the file
ls -lh docker-compose

# Give executable permissions
sudo chmod +x docker-compose

# Verify
ls -l docker-compose

# Verify installation
docker-compose version
