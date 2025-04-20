{pkgs, ...}: {
  home.packages = with pkgs; [
    (xfce.thunar.override {
      thunarPlugins = [
        xfce.thunar-archive-plugin
        xfce.thunar-media-tags-plugin
      ];
    })
  ];
}
