{ pkgs, ... }:
{
  imports = [
    ./pipewire.nix
    ./dbus.nix
    ./gnome-keyring.nix
    ./fonts.nix
  ];

  environment.systemPackages = [
    pkgs.wayland
    pkgs.sddm-chili-theme
    # (pkgs.sddm-chili-theme.override {
    #   themeConfig = {
    #     # background = ../../user/wm/wallpaper.png;
    #     ScreenWidth = 1920;
    #     ScreenHeight = 1080;
    #     blur = true;
    #     recursiveBlurLoops = 3;
    #     recursiveBlurRadius = 5;
    #   };
    # })
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

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      theme = "chili";
    };
  };
}
