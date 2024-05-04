{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (retroarch.override {
      cores = with libretro; [
        snes9x
        dolphin
        mupen64plus
      ];
    })
  ];
}

