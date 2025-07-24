{ pkgs, ... }:
{
  home.packages = with pkgs; [
    verilator
    gtkwave
  ];
}
