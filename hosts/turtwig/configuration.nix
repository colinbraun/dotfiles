{
  config,
  pkgs,
  lib,
  userSettings,
  systemSettings,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../common-desktop.nix
    (./. + "../../../system/wm" + ("/" + userSettings.wm) + ".nix")
  ];

  system.stateVersion = "25.05";

  networking.hostName = "turtwig";

  # Device tree
  hardware.deviceTree.name = "rockchip/rk3588-orangepi-5-plus.dtb";
  hardware.deviceTree.filter = "rk3588-orangepi-5-plus.dtb";

  # Linux Firmware (needed for GPU to work on this platform, I believe)
  hardware.enableRedistributableFirmware = true;

  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_latest;

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

      # Note: Orange Pi 5 Plus typically names its primary ports HDMI-A-1 or HDMI-A-2.
      # The 'M' flag forces the driver to generate standard VESA CVT timings.
      "video=HDMI-A-1:1920x1200M@60"
    ];
  };

  networking.firewall.allowedTCPPorts = [
    22
    25565
  ];
  # networking.firewall.allowedUDPPorts = [9];

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [
        "electro"
        "skeletor"
      ]; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  # Second admin user, turtwig only. Same groups as electro (wheel = sudo).
  # Password is set imperatively with `sudo passwd skeletor` after rebuild.
  users.users.skeletor = {
    isNormalUser = true;
    description = "Skeletor";
    extraGroups = [
      "dialout"
      "docker"
      "libvirtd"
      "lp"
      "networkmanager"
      "podman"
      "uinput"
      "usb"
      "wheel"
    ];
    packages = [ ];
  };

  # common-base.nix sets trusted-users = [ "electro" ]; override here to include both.
  nix.settings.trusted-users = [
    "electro"
    "skeletor"
  ];

  services.desktopManager.plasma6.enable = true;

  systemd.tmpfiles.rules = [
    "w /sys/class/leds/green:indicator-2/brightness - - - - 32"
  ];

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true; # Enables support for Bluetooth
    powerOnBoot = true; # Powers up the default Bluetooth controller on boot
  };
}
