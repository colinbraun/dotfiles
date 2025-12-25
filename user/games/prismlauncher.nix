{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (prismlauncher.override { jdks = [ temurin-jre-bin-25 ]; })
  ];
}
