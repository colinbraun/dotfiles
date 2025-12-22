{ pkgs, ... }:
{
  home.packages = with pkgs; [
    temurin-jre-bin
    # temurin-jre-bin-25
  ];
}
