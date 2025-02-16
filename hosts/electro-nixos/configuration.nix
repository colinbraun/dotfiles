{
  config,
  pkgs,
  userSettings,
  systemSettings,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common-configs.nix
    ../../system/modules/bluetooth.nix
    ../../system/custom/wii-u-gc-adapter.nix
    ../../system/network/network.nix
    (./. + "../../../system/wm" + ("/" + userSettings.wm) + ".nix")
  ];

  networking.hostName = "electro-nixos";

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

  # Not sure if this is needed
  hardware.enableRedistributableFirmware = true;

  # I believe this is for OpenGL
  # Also Needed for video acceleration
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
    ];
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

  networking.firewall.allowedTCPPorts = [25565 69 46446];

  # DO NOT CHANGE. READ DOCUMENTATION FIRST. THIS IS NOT THE SYSTEM VERSION
  system.stateVersion = "23.11";
}
