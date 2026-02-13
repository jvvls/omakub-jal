#!/usr/bin/env bash
set -e

install_if_missing() {
    if dpkg -s "$1" >/dev/null 2>&1; then
        echo "$1 já instalado."
    else
        sudo apt install -y "$1"
    fi
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}
