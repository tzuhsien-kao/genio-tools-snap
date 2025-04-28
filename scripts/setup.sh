#!/bin/bash

CONFIG_DIR="$HOME/.config/genio-tools"
INSTALL_SCRIPT="$CONFIG_DIR/install.sh"

mkdir -p "$CONFIG_DIR"

cat > "$INSTALL_SCRIPT" <<'EOF'
#!/bin/bash

echo "🔗 Connecting required snap interfaces..."
sudo snap connect genio-tools:raw-usb :raw-usb
sudo snap connect genio-tools:network-observe :network-observe
sudo snap connect genio-tools:hardware-observe :hardware-observe

RULE_FILE="/etc/udev/rules.d/72-aiot.rules"

echo "🔧 Installing udev rule for your USB device..."
sudo tee "$RULE_FILE" > /dev/null <<EOR
SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", ATTR{idProduct}=="201c", MODE="0660", TAG+="uaccess"
SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", ATTR{idProduct}=="0003", MODE="0660", TAG+="uaccess"
SUBSYSTEM=="usb", ATTR{idVendor}=="0403", MODE="0660", TAG+="uaccess"
EOR

sudo udevadm control --reload-rules
sudo udevadm trigger

echo "✅ udev rule installed."
echo "📎 Please reconnect your USB device to apply the new rules."
EOF

chmod +x "$INSTALL_SCRIPT"

echo "✅ install.sh has been created at $INSTALL_SCRIPT"
echo "🎯 Please run the following command manually to apply the udev rules and connect required interfaces:"
echo "sudo bash $INSTALL_SCRIPT"
