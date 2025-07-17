{...}: {
  home.stateVersion = "23.11";

  imports = [
    ../home-common-base.nix
    ../../user/lang/java.nix
    # ../../user/app/obs/obs.nix
    # ../../user/app/vlc/vlc.nix
    # ../../user/games/prismlauncher.nix
    # ../../user/lang/python.nix
    # ../../user/udiskie.nix
  ];
}
