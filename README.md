# 🔵 bluetoothland

> Lightweight Bluetooth device manager for Hyprland and other Wayland compositors

A simple, dependency-light solution for managing Bluetooth connections on tiling window managers like Hyprland, Sway, and i3. No heavy GUI managers needed - just clean scripts using `bluetoothctl` and `wofi`.

## The Problem

When you migrate from GNOME/KDE to Hyprland or other minimal window managers, you lose the built-in Bluetooth GUI:

- **Hyprland/Sway** don't include Bluetooth management tools
- **blueman** requires many dependencies (including conflicting bluez packages)
- **GNOME Settings** (`gnome-control-center`) only works in GNOME/Unity
- You just want to connect your headphones quickly!

## The Solution

bluetoothland provides two simple scripts:

1. **`bt-connect`** - Interactive terminal menu
2. **`bt-connect-gui`** - Wofi-based GUI (perfect for Waybar integration)

### Features

- ✅ Minimal dependencies (just `bluetoothctl` and optionally `wofi`)
- ✅ Auto-disconnect other devices when connecting (no conflicts)
- ✅ Shows connection status with visual indicators
- ✅ Integrates seamlessly with Waybar or any status bar
- ✅ Works on any Wayland compositor
- ✅ Zero configuration needed

## Installation

```bash
git clone https://github.com/yourusername/bluetoothland.git
cd bluetoothland
./install.sh
```

This installs the scripts to `~/.local/bin/` and makes them executable.

### Manual Installation

```bash
cp bt-connect bt-connect-gui ~/.local/bin/
chmod +x ~/.local/bin/bt-connect ~/.local/bin/bt-connect-gui
```

## Usage

### Terminal Version

```bash
bt-connect
```

Shows an interactive menu with all paired devices. Select a number to connect/disconnect.

### GUI Version (Wofi)

```bash
bt-connect-gui
```

Opens a clean wofi menu. Click your device and press Enter to connect/disconnect.

### Waybar Integration

Add this to your `~/.config/waybar/config`:

```json
{
    "bluetooth": {
        "format": " {status}",
        "format-connected": " {device_alias}",
        "on-click": "bt-connect-gui"
    }
}
```

See [`waybar-example.json`](waybar-example.json) for a complete configuration.

Now clicking the Bluetooth icon in Waybar opens the connection menu!

## Requirements

- `bluetoothctl` (from `bluez-utils` or similar package)
- `wofi` (only for GUI version)
- `notify-send` / `libnotify` (for notifications)

**On Ubuntu/Debian:**
```bash
sudo apt install bluez-utils wofi libnotify-bin
```

**On Arch:**
```bash
sudo pacman -S bluez-utils wofi libnotify
```

## First-Time Device Pairing

To pair a new device for the first time, use `bluetoothctl`:

```bash
bluetoothctl
power on
scan on
# Wait for your device to appear (e.g., "Device XX:XX:XX:XX:XX:XX Headphones")
pair XX:XX:XX:XX:XX:XX
trust XX:XX:XX:XX:XX:XX
connect XX:XX:XX:XX:XX:XX
exit
```

After pairing once, use `bt-connect` or `bt-connect-gui` for quick reconnections!

## How It Works

- Uses `bluetoothctl` (the official Bluetooth CLI) under the hood
- Automatically powers on the Bluetooth adapter when needed
- Disconnects other audio devices before connecting (prevents conflicts)
- Shows desktop notifications for connection status

## Why "bluetoothland"?

A nod to **Hyprland** and **Wayland** - the modern compositor ecosystem this tool was built for! 🌊

## Contributing

PRs welcome! This tool is intentionally simple and focused. Ideas for improvements:

- [ ] Battery level indicators for connected devices
- [ ] Quick toggle for last-connected device
- [ ] Integration examples for other status bars (polybar, eww)

## License

MIT - Feel free to use, modify, and share!

## Credits

Created by Bruno and Claude Sonnet 4.5 for the Hyprland community.

Built with ❤️  and frustration at complicated Bluetooth managers.
