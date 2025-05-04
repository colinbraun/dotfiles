{pkgs, ...}: {
  home.packages = with pkgs; [
    temurin-jre-bin
  ];
}
