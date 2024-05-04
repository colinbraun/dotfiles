{ pkgs, ... }:
{
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      # Fonts
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      # powerline
      # inconsolata
      # inconsolata-nerdfont
      # iosevka
      # font-awesome
      ubuntu_font_family
      # terminus_font
    ];
    fontconfig.defaultFonts = {
      monospace = [ "FiraCode Nerd Font" ];
      serif = [ "DejaVu Serif" ];
      sansSerif = [ "DejaVu Sans" ];
    };
  };
}

