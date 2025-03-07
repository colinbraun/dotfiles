{pkgs, ...}: let
  # My shell aliases
  myAliases = {
    c = "clear";
    ga = "git add";
    gau = "git add --update";
    gb = "git branch";
    gbl = "git blame -w";
    gc = "git commit --verbose";
    gcl = "git clean";
    gco = "git checkout";
    gd = "git diff";
    gf = "git fetch";
    gl = "git pull";
    glo = "git log --oneline --decorate";
    glog = "git log --oneline --decorate --graph";
    gm = "git merge";
    gp = "git push";
    gr = "git remote";
    grb = "git rebase";
    grbf = "git add -u; git commit -m Fix; git rebase -i HEAD~2";
    gst = "git status";
    gsta = "git stash";
    gstal = "git stash list";
    gstap = "git stash pop";
    gt = "git tag";
    gtl = "git tag --list";
    grep = "grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}";
    history = "history 0";
    h = "history";
    l = "ls -lah";
    la = "ls -Ah";
    ll = "ls -lh";
    ls = "ls --color";
    o = "xdg-open";
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
    ze = "vi /home/electro/.zshrc";
    zl = "source /home/electro/.zshrc";
    less = "less -Ri"; # Show colors, smart case
    rg = "rg -S"; # Smart case
    ag = "rg";
  };
in {
  imports = [
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    fzf
    zsh-fzf-tab
  ];

  home.file.".p10k.zsh" = {
    source = ./p10k.zsh;
  };

  programs.zsh = {
    enable = true;
    # history = {
    #   ignoreAllDups = true;
    #   ignoreSpace = true;
    #   save = 10000;
    #   share = true;
    # };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    shellAliases = myAliases;

    initExtraFirst = ''
    '';
    initExtra = ''
      # zsh-syntax-highlighting, zsh-completions, and zsh-autosuggestions
      # should already be setup by HM.
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh
      # source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      source ~/.p10k.zsh

      HISTSIZE=10000
      HISTFILE=~/.zsh_history
      SAVEHIST=$HISTSIZE
      HISTDUP=erase
      setopt appendhistory
      setopt sharehistory
      setopt hist_ignore_space
      setopt hist_ignore_all_dups
      setopt hist_ignore_dups
      setopt hist_save_no_dups
      setopt hist_find_no_dups

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Case-insensitive tab-complete
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}" # Colored tab-complete
      zstyle ':completion:*' menu select # Make tab-complete cycling highlight the item
      # REMOVE THESE 3 IF ZSH-FZF-TAB IS NOT INSTALLED
      # zstyle ':completion:*' menu no
      # zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
      # zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

      # History search completion by pressing up/down
      autoload -U history-search-end
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end
      bindkey '^[OA' history-beginning-search-backward-end   # Up
      bindkey '^[[A' history-beginning-search-backward-end   # Up
      bindkey '^[OB' history-beginning-search-forward-end # Down
      bindkey '^[[B' history-beginning-search-forward-end # Down

      bindkey '\e[1~' beginning-of-line            # Home
      bindkey '\e[7~' beginning-of-line            # Home
      bindkey '\e[H'  beginning-of-line            # Home
      bindkey '\eOH'  beginning-of-line            # Home

      bindkey '\e[4~' end-of-line                  # End
      bindkey '\e[8~' end-of-line                  # End
      bindkey '\e[F ' end-of-line                  # End
      bindkey '\eOF'  end-of-line                  # End

      bindkey '^?'    backward-delete-char         # Backspace
      bindkey '\e[3~' delete-char                  # Del
      # bindkey '\e[3;5~' delete-char                # sometimes Del, sometimes C-Del
      bindkey '\e[2~' overwrite-mode               # Ins

      bindkey '^H'      backward-kill-word         # C-Backspace

      bindkey '5~'      kill-word                  # C-Del
      bindkey '^[[3;5~' kill-word                  # C-Del
      bindkey '^[[3^'   kill-word                  # C-Del

      bindkey "^[[1;5H" backward-kill-line         # C-Home
      bindkey "^[[7^"   backward-kill-line         # C-Home

      bindkey "^[[1;5F" kill-line                  # C-End
      bindkey "^[[8^"   kill-line                  # C-End

      bindkey '^[[1;5C' forward-word               # C-Right
      bindkey '^[0c'    forward-word               # C-Right
      bindkey '^[[5C'   forward-word               # C-Right

      bindkey '^[[1;5D' backward-word              # C-Left
      bindkey '^[0d'    backward-word              # C-Left
      bindkey '^[[5D'   backward-word              # C-Left
    '';
    # bindkey -s ^f "tmux-sessionizer\n"

    # oh-my-zsh = {
    #   enable = true;
    #   theme = "refined";
    #   plugins = [
    #     "git"
    #   ];
    # };
  };

  # home.file.".local/bin/tmux-sessionizer" = {
  #   source = ./scripts/tmux-sessionizer;
  #   executable = true;
  # };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

  home.shell.enableShellIntegration = true;

  # home.packages = with pkgs; [
  #   disfetch lolcat cowsay onefetch
  #   gnugrep gnused
  #   bat eza bottom fd bc
  #   direnv nix-direnv
  # ];

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;
}
