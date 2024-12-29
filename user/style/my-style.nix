{
  pkgs,
  config,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    # cursorTheme.package = pkgs.bibata-cursors;
    # cursorTheme.name = "Bibata-Modern-Ice";
  };
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme.name = "adwaita";
  };

  home.sessionVariables.GTK_THEME = config.gtk.theme.name; # for gtk4
}
