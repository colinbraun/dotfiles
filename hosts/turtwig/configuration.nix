{
  config,
  pkgs,
  lib,
  userSettings,
  systemSettings,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common-configs.nix
    ../../system/network/network.nix
    (./. + "../../../system/wm" + ("/" + userSettings.wm) + ".nix")
  ];

  networking.hostName = "turtwig";

  # Select additional kernel modules to install (not automatically loaded)
  # Can also select a specific kernel to use if desired
  # boot.extraModulePackages = [
  #   # Virtual camera for OBS
  #   config.boot.kernelPackages.v4l2loopback
  # ];
  # # Modules to be automatically loaded in second stage of boot process
  # boot.kernelModules = [
  #   "v4l2loopback"
  # ];

  # Device tree
  hardware.deviceTree.name = "rockchip/rk3588-orangepi-5-plus.dtb";

  # Linux Firmware (needed for GPU to work on this platform, I believe)
  hardware.enableRedistributableFirmware = true;

  hardware.graphics.enable = true;

  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_latest;
    # fix zfs broken module
    supportedFilesystems = lib.mkForce [
      "vfat"
      "fat32"
      "exfat"
      "ext4"
      "btrfs"
    ];

    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };

    kernelParams = [
      "rootwait"

      "earlycon" # enable early console, so we can see the boot messages via serial port / HDMI
      "consoleblank=0" # disable console blanking(screen saver)
      "console=ttyS2,1500000" # serial port
      "console=tty1" # HDMI

      # docker optimizations
      "cgroup_enable=cpuset"
      "cgroup_memory=1"
      "cgroup_enable=memory"
      "swapaccount=1"
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

  system.stateVersion = "25.05"; # Did you read the comment?
}
