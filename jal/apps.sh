#!/usr/bin/env bash
set -e

# Carrega funções utilitárias (install_if_missing, command_exists)
source "$(dirname "$0")/core.sh"

echo "=== Atualizando repositórios ==="
sudo apt update

echo "=== Habilitando multiverse (necessário para Steam nativa) ==="
sudo add-apt-repository -y multiverse || true
sudo apt update

echo "=== Instalando Apps Extras ==="

# ----------------------
# Steam 
# ----------------------
if ! command_exists steam; then
    echo "Instalando Steam (nativa)..."
    sudo apt install -y steam-installer
else
    echo "Steam já instalada."
fi

# ----------------------
# Discord
# ----------------------
if ! flatpak info com.discordapp.Discord >/dev/null 2>&1; then
    echo "Instalando Discord via Flatpak..."

    if ! command_exists flatpak; then
        echo "Flatpak não encontrado. Instalando Flatpak..."
        sudo apt install -y flatpak
    fi

    if ! flatpak remote-list --columns=name | grep -q '^flathub$'; then
        echo "Adicionando repositório Flathub..."
        sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    fi

    sudo flatpak install -y flathub com.discordapp.Discord
else
    echo "Discord já instalado."
fi

# ----------------------
# Brave Browser
# ----------------------
if ! command_exists brave-browser; then
    echo "Instalando Brave Browser..."
    sudo curl -fsSLo /usr/share/keyrings/brave-browser.gpg \
        https://brave.com/static-assets/images/brave-browser-release-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
        | sudo tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null

    sudo apt update
    sudo apt install -y brave-browser
else
    echo "Brave Browser já instalado."
fi

# ----------------------
# GIMP
# ----------------------
install_if_missing gimp

echo "=== Apps Extras concluídos ==="
