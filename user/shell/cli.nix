# Command line tools
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    fastfetch
    fd
    ripgrep
    rsync
    tree
    unzip
    yazi
    zip
  ];

  programs = {
    gpg.enable = true;
  };
}
