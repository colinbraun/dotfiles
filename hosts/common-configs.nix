{
  pkgs,
  userSettings,
  systemSettings,
  ...
}: {
  imports = [
    ../system/modules/fhs-compat.nix # nix-ld for running downloaded elfs
    ../system/network/network.nix # Common network configurations
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = ["networkmanager" "wheel" "usb" "uinput" "lp" "dialout"];
    packages = [];
  };

  time.timeZone = systemSettings.timezone;

  # Select internationalization properties.
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  services = {
    # Setup udev rules for all kinds of devices
    udev = {
      packages = [
        pkgs.game-devices-udev-rules
      ];
    };
    # D-Bus interface to query storage devices. Used by programs like udevil.
    udisks2.enable = true;
  };

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    file
    git
    home-manager
    man-pages
    usbutils
    vim
    wget
    zsh
  ];

  programs = {
    zsh.enable = true;
  };

  # Man pages / documentation is nice to have and not that much disk space
  documentation = {
    dev.enable = true;
    man.generateCaches = true;
    nixos.includeAllModules = true;
  };

  # Make zsh the default
  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;

  # Some programs try to enable this heavy accessibility option, disable it.
  services.speechd.enable = false;

  hardware.uinput.enable = true;

  hardware.graphics = {
    # Enable hardware-accelerated graphics drivers
    enable = true;
    # Enbable hardware-accelerated video
    extraPackages = with pkgs; [
      libvdpau-va-gl
    ];
  };
}
