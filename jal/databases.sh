#!/usr/bin/env bash
set -e

source "$(dirname "$0")/core.sh"

UBUNTU_CODENAME=$(lsb_release -cs)

echo "=== Instalando Databases ==="

install_if_missing postgresql
install_if_missing postgresql-contrib
install_if_missing mysql-server
install_if_missing redis-server

# MongoDB
if ! dpkg -s mongodb-org >/dev/null 2>&1; then
    wget -qO - https://pgp.mongodb.com/server-7.0.asc | \
    gpg --dearmor -o mongodb-server.gpg

    sudo mv mongodb-server.gpg /usr/share/keyrings/

    echo "deb [ arch=amd64 signed-by=/usr/share/keyrings/mongodb-server.gpg ] https://repo.mongodb.org/apt/ubuntu $UBUNTU_CODENAME/mongodb-org/7.0 multiverse" \
    | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

    sudo apt update
    sudo apt install -y mongodb-org
else
    echo "MongoDB já instalado."
fi
