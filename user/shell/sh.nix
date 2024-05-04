{ pkgs, ... }:
let
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
    grep = "grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}";
    l = "ls -lah";
    la = "ls -lAh";
    ll = "ls -lh";
    ls = "ls --color=tty";
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
in
{
  imports = [
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    zsh-powerlevel10k
    fzf
  ];

  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
    # historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;

    initExtra = ''
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh
      bindkey -s ^f "tmux-sessionizer\n"
    '';


    oh-my-zsh = {
      enable = true;
      theme = "refined";
      plugins = [
        "git"
        # "kubectl"
        # "helm"
        # "docker"
      ];
    };
  };

  home.file.".local/bin/tmux-sessionizer" = {
    source = ./scripts/tmux-sessionizer;
    executable = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

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

