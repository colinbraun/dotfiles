# Command line tools
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    fastfetch
    ripgrep
    rsync
    unzip
    zip
  ];

  programs = {
    gpg.enable = true;
  };
}
