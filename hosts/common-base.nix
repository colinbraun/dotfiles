{
  pkgs,
  userSettings,
  systemSettings,
  ...
}:
{
  imports = [
    ../system/modules/fhs-compat.nix # nix-ld for running downloaded elfs
    ../system/network/network.nix # Common network configurations
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [
      "networkmanager"
      "wheel"
      "usb"
      "uinput"
      "lp"
      "dialout"
      "podman"
    ];
    packages = [ ];
  };

  time.timeZone = systemSettings.timezone;

  # Select internationalization properties.
  i18n = {
    defaultLocale = systemSettings.locale;
    extraLocaleSettings = {
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
  };

  nix = {
    settings = {
      # Enable flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # Must be trusted user to use substituters
      trusted-users = [ "${userSettings.username}" ];
    };
  };

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
    nano.enable = false; # Nano is enabled by default (yuck)
  };

  # Man pages / documentation is nice to have and not that much disk space
  documentation = {
    dev.enable = true;
    # man.generateCaches = true;
    nixos.includeAllModules = true;
  };

  # Make zsh the default
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  hardware.uinput.enable = true;
}
