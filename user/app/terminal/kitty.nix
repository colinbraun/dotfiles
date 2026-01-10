{
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    kitty
  ];
  programs.kitty.enable = true;
  programs.kitty.settings = {
    background_opacity = lib.mkForce "0.66";
    "# Mappings" = lib.strings.concatStringsSep "\n" [
      ""
      "map ctrl+backspace send_text all \\x17"
      "map kitty_mod+p"
      "map kitty_mod+n"
    ];
  };
}
