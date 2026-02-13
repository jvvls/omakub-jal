#!/usr/bin/env bash
set -e

source "$(dirname "$0")/core.sh"

echo "=== Verificando GPU ==="

if lspci | grep -iq nvidia; then
    echo "GPU NVIDIA detectada."

    sudo ubuntu-drivers autoinstall

    install_if_missing nvidia-cuda-toolkit

    if command_exists nvidia-smi; then
        echo "nvidia-smi funcionando."
    else
        echo "Algo pode ter falhado no driver."
    fi

else
    echo "NVIDIA não detectada. Pulando."
fi
