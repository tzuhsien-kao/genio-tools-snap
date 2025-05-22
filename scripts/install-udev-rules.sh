# scripts/install-udev-rules.sh
#!/bin/bash

RULE_FILE="/etc/udev/rules.d/72-aiot.rules"

echo "🔧 Installing udev rule for your USB device..."
sudo tee "$RULE_FILE" > /dev/null <<EOR
SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", ATTR{idProduct}=="201c", MODE="0660", TAG+="uaccess"
SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", ATTR{idProduct}=="0003", MODE="0660", TAG+="uaccess"
SUBSYSTEM=="usb", ATTR{idVendor}=="0403", MODE="0660", TAG+="uaccess"
SUBSYSTEM=="tty", ATTRS{idVendor}=="0e8d", ATTRS{idProduct}=="0003", MODE="0660", TAG+="uaccess"
SUBSYSTEM=="gpio", MODE="0660", TAG+="uaccess"
EOR

sudo udevadm control --reload-rules
sudo udevadm trigger

echo "✅ udev rule installed."
echo "📎 Please reconnect your USB device to apply the new rules."
