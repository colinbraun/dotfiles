# Command line tools
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    delta
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
