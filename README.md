# Electro's Dotfiles

Nix flake managing NixOS configurations and home-manager setups across multiple machines.

## Machines

| Host     | Arch     | Role                        |
|----------|----------|-----------------------------|
| electro-nixos | x86_64 | Laptop/desktop |
| pendragon     | x86_64 | Desktop |
| turtwig       | aarch64 | Orange Pi 5 Plus |

## What's Included

- **WM**: Hyprland
- **Shell**: Zsh
- **Terminal**: Kitty
- **Editor**: Neovim
- **Browser**: Firefox
- **File Manager**: Thunar (default), Nautilus, Dolphin
- **Launcher/Bar**: fuzzel + waybar
- **Notifications**: fnott
- **Gaming**: Steam/gamescope, Lutris, Prism Launcher, RetroArch

## Usage

```bash
# Rebuild system
sudo nixos-rebuild switch --flake ~/.dotfiles --print-build-logs --show-trace

# Update home-manager only
home-manager switch --flake ~/.dotfiles --show-trace --print-build-logs

# Update flake lock
nix flake update --flake ~/.dotfiles
```

## Structure

```
├── flake.nix                   # Entry point, hosts + home configs
├── hosts/
│   ├── common-base.nix         # Shared system config (users, time, nix)
│   ├── common-desktop.nix      # Shared desktop system config
│   ├── home-common-base.nix    # Shared home-manager config
│   ├── home-common-desktop.nix # Shared desktop home-manager config
│   └── {host}/                 # Per-machine configs
├── system/                     # System-level NixOS modules
│   ├── modules/                # bluetooth, fhs-compat
│   ├── network/                # networking config
│   ├── custom/                 # DIY services (wii-u-gc-adapter)
│   └── wm/                     # WM modules (hyprland, gnome, pipewire...)
├── user/                       # Home-manager configs
│   ├── app/                    # Apps (browser, terminal, file-manager...)
│   ├── editor/                 # Neovim, VS Code
│   ├── games/                  # Gaming configs
│   ├── lang/                   # Language toolchains (C/C++, Java, Python)
│   ├── shell/                  # Zsh, tmux, direnv
│   ├── style/                  # Theme/font settings
│   └── wm/                     # WM user config (hyprland, waybar, pypr)
└── config/nvim/                # Neovim Lua configuration
```
