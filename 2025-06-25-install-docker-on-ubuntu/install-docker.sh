#!/bin/bash

# Docker Installation Script for Ubuntu.
# This script installs Docker Engine, Docker CLI, containerd, and Docker Compose.
# Author: Claude AI and github.com/johnnymatthews

set -e  # Exit on any error.

echo "🐳 Starting Docker installation on Ubuntu..."

# Update package index.
echo "📦 Updating package index..."
sudo apt-get update

# Install required packages.
echo "📋 Installing required dependencies..."
sudo apt-get install -y ca-certificates curl gnupg

# Add Docker's official GPG key.
echo "🔐 Adding Docker's GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Set up Docker repository.
echo "📁 Setting up Docker repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index again.
echo "🔄 Updating package index with Docker repository..."
sudo apt-get update

# Install Docker Engine, CLI, containerd, and Docker Compose plugin.
echo "⬇️  Installing Docker Engine, CLI, containerd, and Docker Compose plugin..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start and enable Docker service.
echo "🚀 Starting Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

# Install standalone Docker Compose
echo "📦 Installing standalone Docker Compose..."
DOCKER_COMPOSE_VERSION="v2.25.0"
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose

# Add current user to docker group.
echo "👤 Adding current user to docker group..."
sudo usermod -aG docker $USER

# Verify installation.
echo "✅ Verifying Docker installation..."
sudo docker run hello-world

echo ""
echo "Docker installation completed successfully! Either run 'newgrp docker' or log out and back in again."
echo ""
