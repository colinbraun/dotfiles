{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./common-base.nix
  ];

  services = {
    # Setup udev rules for all kinds of devices
    udev = {
      packages = [
        pkgs.game-devices-udev-rules
      ];
    };
    # D-Bus interface to query storage devices. Used by programs like udevil.
    udisks2.enable = true;
  };

  environment.systemPackages = with pkgs; [
    firefox
  ];

  # Some programs try to enable this heavy accessibility option, disable it.
  services.speechd.enable = lib.mkForce false;

  hardware.graphics = {
    # Enable hardware-accelerated graphics drivers
    enable = true;
    # Enbable hardware-accelerated video
    extraPackages = with pkgs; [
      libvdpau-va-gl
    ];
  };
}
