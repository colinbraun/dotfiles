{
  config,
  pkgs,
  userSettings,
  ...
}:
{
  system.stateVersion = "24.05";

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common-desktop.nix
    ../../system/custom/wii-u-gc-adapter.nix
    ../../system/steam.nix
    (./. + "../../../system/wm" + ("/" + userSettings.wm) + ".nix")
  ];

  networking.hostName = "pendragon";

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
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
    # Kernel
    kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackagesFor (
    #   pkgs.buildLinux {
    #     src = pkgs.fetchurl {
    #       url = "https://git.kernel.org/torvalds/t/linux-6.14-rc7.tar.gz";
    #       hash = "sha256-ilYQOd9IxeYERlXPt3G5AU+9ffZ137zFK/Kfu3AR2Uw=";
    #     };
    #     version = "6.14-rc7";
    #   }
    # );
  };

  # Misc things for this machine
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22
      2626
    ];
    allowedUDPPorts = [
      2626
    ];
  };

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

  services.atftpd.enable = true;

  services.desktopManager.plasma6.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # services.nfs.server.enable = true;
  # services.nfs.server.exports = ''
  #   /srv/nfs/rootfs *(rw,sync,no_subtree_check,no_root_squash)
  # '';
}
