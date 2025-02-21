{
  config,
  pkgs,
  userSettings,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common-configs.nix
    ../../system/modules/bluetooth.nix
    ../../system/custom/wii-u-gc-adapter.nix
    (./. + "../../system/wm" + ("/" + userSettings.wm) + ".nix")
  ];

  networking.hostName = "electro-nixos";

  boot = {
    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # Select additional kernel modules to install (not automatically loaded)
    # Can also select a specific kernel to use if desired
    extraModulePackages = [
      # Virtual camera for OBS
      config.boot.kernelPackages.v4l2loopback
    ];
    # Modules to be automatically loaded in second stage of boot process
    kernelModules = [
      "v4l2loopback"
    ];

    # Kernel
    kernelPackages = pkgs.linuxKernel.packageAliases.linux_latest;
  };

  # Linux firmware
  hardware.enableRedistributableFirmware = true;

  # Other graphics settings in common-configs.nix
  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
    ];
  };

  networking.firewall.allowedTCPPorts = [25565 69 46446];

  # DO NOT CHANGE. READ DOCUMENTATION FIRST. THIS IS NOT THE SYSTEM VERSION
  system.stateVersion = "23.11";
}
