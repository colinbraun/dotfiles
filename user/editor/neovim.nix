{pkgs, ...}: {
  home.packages = with pkgs; [
    # Faster grep, like silver searcher (ag)
    ripgrep
    lua-language-server
    nil # Nix LSP
    alejandra # Nix formatter
    pyright
  ];

  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.which-key-nvim
      pkgs.vimPlugins.lz-n
      pkgs.vimPlugins.cmp-nvim-lsp
      pkgs.vimPlugins.lspkind-nvim # VSCode-like pictograms for LSP
      pkgs.vimPlugins.nvim-cmp
      pkgs.vimPlugins.gitsigns-nvim
      pkgs.vimPlugins.neogit
      pkgs.vimPlugins.luasnip
      pkgs.vimPlugins.luasnip
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.telescope-ui-select-nvim
      pkgs.vimPlugins.rainbow-delimiters-nvim
      pkgs.vimPlugins.precognition-nvim
      pkgs.vimPlugins.oil-nvim
      pkgs.vimPlugins.trouble-nvim
      pkgs.vimPlugins.nvim-surround
      pkgs.vimPlugins.markdown-nvim
      pkgs.vimPlugins.nabla-nvim
      pkgs.vimPlugins.lualine-nvim
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      pkgs.vimPlugins.indent-blankline-nvim
      pkgs.vimPlugins.noice-nvim
      pkgs.vimPlugins.onedark-nvim
      pkgs.vimPlugins.none-ls-nvim
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.crates-nvim
      pkgs.vimPlugins.vim-tmux-navigator
      pkgs.vimPlugins.nvim-autopairs
    ];
  };
}
