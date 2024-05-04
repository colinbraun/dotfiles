{ pkgs, ... }:

{
  # Import wayland config
  imports = [
    ./wayland.nix
    ./pipewire.nix
    ./dbus.nix
  ];

  services.xserver.desktopManager.gnome.enable = true;

  # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "electro";
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-text-editor # Text editor
    ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    # gnome-terminal
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);
}

