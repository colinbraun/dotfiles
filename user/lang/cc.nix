{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # CC
    gcc
    gnumake
    autoconf
    automake
    libtool
  ];
}
