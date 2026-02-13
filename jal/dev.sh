#!/usr/bin/env bash
set -e

echo "=== Ambiente Dev Extra ==="

if ! snap list | grep -q eclipse; then
    sudo snap install eclipse --classic
else
    echo "Eclipse já instalado."
fi
