# Common home-manager configurations for any machine with a desktop environment
{ userSettings, ... }:
{
  imports = [
    ./home-common-base.nix
    (./. + "/../user/wm" + ("/" + userSettings.wm) + ".nix") # My window manager selected from flake
    (./. + "/../user/app/browser" + ("/" + userSettings.browser) + ".nix") # My default browser
    (./. + "/../user/app/file-manager" + ("/" + userSettings.fileManager) + ".nix") # My file manager
    ../user/lang/cc.nix
    ../user/style/my-style.nix
  ];
}
