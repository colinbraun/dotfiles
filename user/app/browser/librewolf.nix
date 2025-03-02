{pkgs, ...}: {
  # Module installing as default browser
  home.packages = [pkgs.librewolf];

  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf";
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = "librewolf.desktop";
    "x-scheme-handler/http" = "librewolf.desktop";
    "x-scheme-handler/https" = "librewolf.desktop";
    "x-scheme-handler/about" = "librewolf.desktop";
    "x-scheme-handler/unknown" = "librewolf.desktop";
  };
}
