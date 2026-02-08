#!/bin/bash
# bluetoothland installer

set -e

INSTALL_DIR="${HOME}/.local/bin"
SCRIPTS=("bt-connect" "bt-connect-gui")

echo "🔵 bluetoothland installer"
echo ""

# Check if bluetoothctl is available
if ! command -v bluetoothctl &> /dev/null; then
    echo "❌ Error: bluetoothctl not found"
    echo "Please install bluez or ensure bluetooth daemon is running"
    exit 1
fi

# Check if wofi is available (for GUI version)
if ! command -v wofi &> /dev/null; then
    echo "⚠️  Warning: wofi not found"
    echo "bt-connect-gui requires wofi. Install it with:"
    echo "  sudo apt install wofi    # Ubuntu/Debian"
    echo "  sudo pacman -S wofi      # Arch"
    echo ""
    echo "Terminal version (bt-connect) will still work."
    echo ""
fi

# Create install directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Copy scripts
echo "Installing scripts to $INSTALL_DIR..."
for script in "${SCRIPTS[@]}"; do
    if [ -f "$script" ]; then
        cp "$script" "$INSTALL_DIR/"
        chmod +x "$INSTALL_DIR/$script"
        echo "  ✓ $script"
    else
        echo "  ❌ $script not found (skipping)"
    fi
done

echo ""
echo "✅ Installation complete!"
echo ""
echo "Usage:"
echo "  bt-connect        - Terminal version with interactive menu"
echo "  bt-connect-gui    - GUI version with wofi (for Waybar integration)"
echo ""
echo "To integrate with Waybar, add to your ~/.config/waybar/config:"
echo '  "bluetooth": {'
echo '    "format": " {status}",'
echo '    "on-click": "bt-connect-gui"'
echo '  }'
echo ""
