{ pkgs, ... }:
{
  home.stateVersion = "26.05";

  imports = [
    ../home-common-base.nix
    ../../user/lang/java.nix
  ];

  home.packages = with pkgs; [
  ];
}
