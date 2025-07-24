{ pkgs, ... }:
{
  home.packages = with pkgs; [
  ];

  programs.obs-studio = {
    enable = true;
  };
}
