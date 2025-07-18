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
    ../common-base.nix
    # (./. + "../../../system/wm" + ("/" + userSettings.wm) + ".nix")
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
  hardware.deviceTree.filter = "rk3588-orangepi-5-plus.dtb";

  # Linux Firmware (needed for GPU to work on this platform, I believe)
  hardware.enableRedistributableFirmware = true;

  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackagesFor (
    #   pkgs.buildLinux {
    #     src = pkgs.fetchgit {
    #       # url = "git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git";
    #       url = "https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux.git";
    #       deepClone = false;
    #       hash = "sha256-kSkF85kVxVoJMlvWxX3GjDweuppHohhKY2djTauKp7c=";
    #       rev = "3ae3a541e5a1a98ad0149dbcdfce2a85d4877bac";
    #       # url = "https://git.kernel.org/torvalds/t/linux-6.14-rc7.tar.gz";
    #       # hash = "sha256-ilYQOd9IxeYERlXPt3G5AU+9ffZ137zFK/Kfu3AR2Uw=";
    #     };
    #     version = "6.14.0";
    #     ignoreConfigErrors = true;
    #   }
    # );

    # fix zfs broken module
    # supportedFilesystems = lib.mkForce [
    #   "vfat"
    #   "fat32"
    #   "exfat"
    #   "ext4"
    #   "btrfs"
    # ];

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

  # services.desktopManager.plasma6.enable = true;

  networking.firewall.allowedTCPPorts = [22 25565];
  # networking.firewall.allowedUDPPorts = [9];

  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = ["electro"]; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

}
