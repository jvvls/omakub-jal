#!/usr/bin/env bash
set -e

JAL_VERSION="1.0.0"

echo "======================================"
echo "        OMAKUB + JAL LAYER v$JAL_VERSION"
echo "======================================"

# Detect Ubuntu
if ! command -v lsb_release >/dev/null 2>&1; then
    sudo apt update && sudo apt install -y lsb-release
fi

UBUNTU_CODENAME=$(lsb_release -cs)
UBUNTU_VERSION=$(lsb_release -rs)

echo "Ubuntu detectado: $UBUNTU_VERSION ($UBUNTU_CODENAME)"

# Instala Omakub oficial primeiro
echo "Instalando Omakub oficial..."
wget -qO- https://omakub.org/install | bash

# Executa camada JAL
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

bash "$BASE_DIR/jal/core.sh"
bash "$BASE_DIR/jal/apps.sh"
bash "$BASE_DIR/jal/nvidia.sh"
bash "$BASE_DIR/jal/dev.sh"
bash "$BASE_DIR/jal/databases.sh"

echo "Instalação completa."
