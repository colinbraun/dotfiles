{ pkgs, ... }:
let
  wii-u-gc-adapter = pkgs.stdenv.mkDerivation {
    name = "wii-u-gc-adapter";
    src = pkgs.fetchFromGitHub {
      owner = "ToadKing";
      repo = "wii-u-gc-adapter";
      rev = "fa098efa7f6b34f8cd82e2c249c81c629901976c";
      sha256 = "sha256-wm0vDU7QckFvpgI50PG4/elgPEkfr8xTmroz8kE6QMo=";
    };
    buildInputs = [
      pkgs.udev
      pkgs.libusb1
    ];
    nativeBuildInputs = [
      pkgs.pkg-config
    ];

    hardeningDisable = [ "all" ];

    installPhase = ''
      mkdir -p $out/bin
      cp wii-u-gc-adapter $out/bin
    '';
  };
in
{
  systemd.services."wii-u-gc-adapter" = {
    enable = true; # Just start the service yourself if you want to use it
    description = "USB Wii U Gamecube Adapter Manager";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${wii-u-gc-adapter}/bin/wii-u-gc-adapter";
    };
    wantedBy = [ "graphical.target" ];
  };
  # Extra udev rules
  # TODO: Consider changing this to use the dolphin-rules package
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
  '';
  # Modules to be automatically loaded in second stage of boot process
  boot.kernelModules = [
    "uinput"
  ];
}
