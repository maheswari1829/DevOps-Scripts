#!/bin/bash

# ----------------------------------------
# PORTAINER SETUP
# ----------------------------------------

# Portainer is a container management tool
# used to manage Docker environments,
# Swarm clusters, and Kubernetes clusters.

# Portainer consists of:
# 1. Portainer Server
# 2. Portainer Agent

# Recommended for:
# - Production environments
# - Multi-cluster management
# - Container monitoring
# - Stack deployment

# ----------------------------------------
# REQUIREMENTS
# ----------------------------------------

# - Docker Engine installed
# - Docker Swarm enabled
# - Required ports open

# Initialize Docker Swarm (if not initialized)
docker swarm init

# Download Portainer agent stack file
curl -L https://downloads.portainer.io/ce2-16/portainer-agent-stack.yml \
-o portainer-agent-stack.yml

# Deploy Portainer stack
docker stack deploy -c portainer-agent-stack.yml portainer

# Verify running containers
docker ps

# Access Portainer
# http://<PUBLIC-IP>:9000
