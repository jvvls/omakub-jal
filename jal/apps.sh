#!/usr/bin/env bash
set -e

source "$(dirname "$0")/core.sh"

sudo apt update

echo "=== Apps Extras ==="

# Steam
install_if_missing steam

# Discord
if ! command_exists discord; then
    wget -q -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
    sudo apt install -y ./discord.deb
    rm discord.deb
fi

# Brave
if ! command_exists brave-browser; then
    sudo curl -fsSLo /usr/share/keyrings/brave-browser.gpg \
    https://brave.com/static-assets/images/brave-browser-release-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
    | sudo tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null

    sudo apt update
    sudo apt install -y brave-browser
fi
