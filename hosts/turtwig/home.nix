{...}: {
  home.stateVersion = "23.11";

  imports = [
    ../home-common-desktop.nix # Common configs for all machines with a desktop
    ../../user/app/obs/obs.nix
    ../../user/app/vlc/vlc.nix
    ../../user/games/prismlauncher.nix
    ../../user/lang/java.nix
    ../../user/lang/python.nix
    ../../user/udiskie.nix
  ];
}
