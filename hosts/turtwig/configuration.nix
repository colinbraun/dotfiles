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

  system.stateVersion = "25.05";

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
    # kernelPackages = pkgs.linuxPackagesFor (
    #   pkgs.buildLinux {
    #     src = pkgs.fetchgit {
    #       url = "git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git";
    #       deepClone = false;
    #       hash = "sha256-TafGpEPOYQ2n3erdHLs9Bh6LDM8bD+RVzie7kvw83gw=";
    #       rev = "refs/tags/v6.15-rockchip-dts64-3";
    #       # url = "https://git.kernel.org/torvalds/t/linux-6.14-rc7.tar.gz";
    #       # hash = "sha256-ilYQOd9IxeYERlXPt3G5AU+9ffZ137zFK/Kfu3AR2Uw=";
    #     };
    #     version = "6.14.0-rc1";
    #   }
    # );

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
}
