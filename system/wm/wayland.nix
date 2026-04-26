{ pkgs, ... }:
{
  imports = [
    ./pipewire.nix
    ./dbus.nix
    ./gnome-keyring.nix
    ./fonts.nix
  ];

  # Configure xwayland
  services = {
    xserver = {
      # Enable the X11 windowing system
      enable = true;
      # X11 Keyboard stuff
      xkb = {
        layout = "us";
        variant = "";
        options = "caps:escape";
      };
    };

    displayManager.gdm.enable = true;
    # Strip down GNOME to just the login manager
    gnome.core-apps.enable = false;
    gnome.core-shell.enable = true; # Required for GDM to render
  };

}
