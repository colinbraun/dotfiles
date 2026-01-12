{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (thunar.override {
      thunarPlugins = [
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    })
  ];
}
