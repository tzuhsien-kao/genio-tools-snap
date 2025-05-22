#!/bin/bash

CONFIG_DIR="$HOME/common"
INSTALL_SCRIPT="$CONFIG_DIR/install-udev-rules.sh"

mkdir -p "$CONFIG_DIR"
cp "$SNAP/bin/install-udev-rules.sh" "$INSTALL_SCRIPT"
chmod +x "$INSTALL_SCRIPT"

echo "✅ install.sh has been created at $INSTALL_SCRIPT"
echo "🎯 Please run the following command manually to apply the udev rules:"
echo "sudo bash $INSTALL_SCRIPT"
