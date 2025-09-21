{ pkgs, ... }:
{
  home.stateVersion = "23.11";

  imports = [
    # ../home-common-base.nix
    ../home-common-desktop.nix
    ../../user/lang/java.nix
    # ../../user/app/obs/obs.nix
    # ../../user/app/vlc/vlc.nix
    # ../../user/games/prismlauncher.nix
    ../../user/games/retroarch.nix
    # ../../user/lang/python.nix
    # ../../user/udiskie.nix
  ];

  home.packages = with pkgs; [
    dolphin-emu
  ];
}
