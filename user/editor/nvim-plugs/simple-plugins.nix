{ pkgs, ... }:
{
  programs.nixvim = {
    # Jump to the last place the file was edited at
    plugins.lastplace.enable = true;
    # gcc/gcb to comment things in/out
    plugins.comment.enable = true;
    # Clean movement between vim splits and tmux panes
    plugins.tmux-navigator.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      ultimate-autopair-nvim
    ];

    extraConfigLua = ''
      require('ultimate-autopair').setup({})
    '';
  };
}

