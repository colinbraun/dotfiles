{pkgs, ...}: {
  home.packages = [
    (pkgs.retroarch.withCores (cores:
      with cores; [
        mgba
        mupen64plus
        dolphin
        snes9x
      ]))
  ];
}
