{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vlc
  ];

  xdg.mimeApps.defaultApplications = {
    "video/mp4" = "vlc.desktop";
  };
}

