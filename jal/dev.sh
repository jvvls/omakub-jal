#!/usr/bin/env bash
set -e

source "$(dirname "$0")/core.sh"

echo "=== Ambiente Dev Extra ==="

sudo apt update

if ! snap list | grep -q eclipse; then
    sudo snap install eclipse --classic
else
    echo "Eclipse já instalado."
fi

echo "=== Setup Java (VS Code) ==="
install_if_missing openjdk-21-jdk
install_if_missing maven

JAVAC_BIN="$(command -v javac || true)"
if [ -n "$JAVAC_BIN" ]; then
    JAVA_HOME_PATH="$(dirname "$(dirname "$(readlink -f "$JAVAC_BIN")")")"
    JAVA_PROFILE_FILE="/etc/profile.d/jdk.sh"
    JAVA_PROFILE_CONTENT="export JAVA_HOME=$JAVA_HOME_PATH
export PATH=\$JAVA_HOME/bin:\$PATH"

    if [ -f "$JAVA_PROFILE_FILE" ] && sudo grep -Fq "export JAVA_HOME=$JAVA_HOME_PATH" "$JAVA_PROFILE_FILE"; then
        echo "JAVA_HOME já configurado em $JAVA_PROFILE_FILE."
    else
        echo "$JAVA_PROFILE_CONTENT" | sudo tee "$JAVA_PROFILE_FILE" >/dev/null
        sudo chmod 644 "$JAVA_PROFILE_FILE"
        echo "JAVA_HOME configurado em $JAVA_PROFILE_FILE."
    fi
else
    echo "javac não encontrado após instalação do JDK."
fi
