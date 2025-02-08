{
  config,
  pkgs,
  userSettings,
  ...
}: {
  imports = [
    (./. + "../../../user/wm" + ("/" + userSettings.wm) + ".nix") # My window manager selected from flake
    (./. + "../../../user/app/browser" + ("/" + userSettings.browser) + ".nix") # My default browser
    (./. + "../../../user/app/file-manager" + ("/" + userSettings.fileManager) + ".nix") # My file manager
    # ../../user/app/messaging/discord.nix
    ../../user/app/obs/obs.nix
    ../../user/app/vlc/vlc.nix
    # ../../user/eda/verilator.nix
    ../../user/editor/neovim.nix
    # ../../user/games/retroarch.nix
    # ../../user/games/lutris.nix
    ../../user/games/prismlauncher.nix
    # ../../user/games/suyu.nix
    ../../user/lang/cc.nix
    ../../user/lang/java.nix
    ../../user/lang/python.nix
    ../../user/shell/cli.nix
    ../../user/shell/direnv.nix
    ../../user/shell/sh.nix
    ../../user/style/my-style.nix
    ../../user/udiskie.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nh # Nix cli helper
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    templates = "${config.home.homeDirectory}/Templates";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
      XDG_ARCHIVE_DIR = "${config.home.homeDirectory}/Archive";
      # XDG_VM_DIR = "${config.home.homeDirectory}/Machines";
      # XDG_ORG_DIR = "${config.home.homeDirectory}/Org";
      XDG_PODCAST_DIR = "${config.home.homeDirectory}/Media/Podcasts";
      XDG_BOOK_DIR = "${config.home.homeDirectory}/Media/Books";
    };
  };
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;

  home.sessionVariables = {
    EDITOR = userSettings.editor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
    FLAKE = "${config.home.homeDirectory}/.dotfiles";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
