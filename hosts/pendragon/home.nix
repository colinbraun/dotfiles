{ pkgs, ... }:
{
  home.stateVersion = "23.11";

  imports = [
    ../home-common-desktop.nix # Common configs for all machines with a desktop
    ../../user/app/messaging/discord.nix
    ../../user/app/obs/obs.nix
    ../../user/app/vlc/vlc.nix
    ../../user/editor/vscode.nix
    ../../user/games/prismlauncher.nix
    ../../user/games/retroarch.nix
    ../../user/lang/java.nix
    ../../user/lang/python.nix
    ../../user/serial.nix
    ../../user/udiskie.nix
  ];

  home.packages = [
    # pkgs.kicad
  ];
}
