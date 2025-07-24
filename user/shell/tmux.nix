{ pkgs, ... }:
{
  # Note this causes strange things when using my own .tmux.conf
  # programs.tmux = {
  # enable = true;
  # };

  home.packages = with pkgs; [
    tmux
  ];
  home.file.".tmux.conf".source = ./tmux.conf;
}
