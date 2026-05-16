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
    ../common-base.nix
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
      AllowUsers = [ "electro" ]; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

}
