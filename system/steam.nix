{ pkgs, ... }:
{
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = [
    pkgs.mangohud
  ];

  programs.gamemode.enable = true;
}
