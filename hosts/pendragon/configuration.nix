{
  config,
  pkgs,
  userSettings,
  systemSettings,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common-configs.nix
    ../common-graphical-configs.nix
    ../../system/custom/wii-u-gc-adapter.nix
    ../../system/network/network.nix
    ../../system/steam.nix
    (./. + "../../../system/wm" + ("/" + userSettings.wm) + ".nix")
    # ../../system/style/stylix.nix
  ];

  networking.hostName = "pendragon";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Select additional kernel modules to install (not automatically loaded)
  # Can also select a specific kernel to use if desired
  boot.extraModulePackages = [
    # Virtual camera for OBS
    config.boot.kernelPackages.v4l2loopback
  ];
  # Modules to be automatically loaded in second stage of boot process
  boot.kernelModules = [
    "v4l2loopback"
  ];

  # Kernel
  # boot.kernelPackages = pkgs.linuxKernel.packageAliases.linux_default;
  boot.kernelPackages = pkgs.linuxKernel.packageAliases.linux_latest;

  # I believe this is for OpenGL
  hardware.graphics.enable = true;

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

  system.stateVersion = "24.05"; # Did you read the comment?
}
