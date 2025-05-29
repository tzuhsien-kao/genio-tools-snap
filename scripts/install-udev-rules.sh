# scripts/install-udev-rules.sh
#!/bin/bash

RULE_FILE="/etc/udev/rules.d/72-genio.rules"

echo "🔧 Installing udev rule for your USB device..."

sudo groupadd gpioaccess || echo "group gpioaccess already exists"
sudo groupadd genio || echo "group genio already exists"

USERNAME=$(logname)
groups $USERNAME | grep -qw gpioaccess || sudo usermod -aG gpioaccess "$USERNAME"
groups $USERNAME | grep -qw genio || sudo usermod -aG genio "$USERNAME"

sudo tee "$RULE_FILE" > /dev/null <<EOR
SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", ATTR{idProduct}=="201c", MODE="0660", TAG+="uaccess", GROUP="genio"
SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", ATTR{idProduct}=="0003", MODE="0660", TAG+="uaccess", GROUP="genio"
SUBSYSTEM=="usb", ATTR{idVendor}=="0403", MODE="0660", TAG+="uaccess", GROUP="genio"
SUBSYSTEM=="tty", ATTRS{idVendor}=="0e8d", ATTRS{idProduct}=="0003", MODE="0660", TAG+="uaccess", GROUP="genio"
SUBSYSTEM=="gpio", MODE="0660", TAG+="uaccess", GROUP="gpioaccess"
EOR

sudo udevadm control --reload-rules
sudo udevadm trigger

echo "✅ udev rule installed."
echo "📎 Please reconnect your USB device to apply the new rules."
echo "🔑 Please log out and log back in (or open a new terminal) to apply group changes."
