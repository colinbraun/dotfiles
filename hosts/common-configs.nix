{ pkgs, ... }:

{

  imports = [
    ../system/modules/fhs-compat.nix # nix-ld for running downloaded elfs
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    file
    git
    home-manager
    man-pages
    usbutils
    vim
    wget
    zsh
  ];

  programs = {
    zsh.enable = true;
  };

  # Man pages / documentation is nice to have and not that much disk space
  documentation = {
    dev.enable = true;
    man.generateCaches = true;
    nixos.includeAllModules = true;
  };

  # Make zsh the default
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  # Some programs try to enable this heavy accessibility option, disable it.
  services.speechd.enable = false;

}

