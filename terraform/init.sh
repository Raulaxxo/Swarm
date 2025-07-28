#!/bin/bash
set -e

echo "🔧 Actualizando sistema..."
sudo apt-get update -y
sudo apt-get upgrade -y

echo "📦 Instalando dependencias..."
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "🔐 Agregando GPG key de Docker..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "📦 Agregando repositorio oficial de Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Actualizando APT con nuevo repositorio..."
sudo apt-get update -y

echo "🐳 Instalando Docker Engine..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "💡 Habilitando Docker para que arranque con el sistema..."
sudo systemctl enable docker
sudo systemctl start docker

echo "➕ Agregando usuario actual al grupo docker..."
sudo usermod -aG docker $USER

echo "🔍 Verificando instalación..."
docker --version
docker compose version

echo "✅ Docker y Docker Compose instalados correctamente."
echo "ℹ️ Reinicia la sesión o ejecuta: newgrp docker"

echo "📂 Creando directorio /docker/swarm para configuraciones de Swarm..."
mkdir -p /docker/

git clone 

