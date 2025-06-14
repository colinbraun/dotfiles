{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra # Nix formatter
    lua-language-server
    nil # Nix LSP
    pyright
    ripgrep # Faster grep, like silver searcher (ag)
  ];

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      cmp-nvim-lsp
      cmp_luasnip
      crates-nvim
      friendly-snippets
      gitsigns-nvim
      indent-blankline-nvim
      lspkind-nvim # VSCode-like pictograms for LSP
      lualine-nvim
      luasnip
      lz-n
      markdown-nvim
      nabla-nvim
      neogit
      noice-nvim
      none-ls-nvim
      nvim-autopairs
      nvim-cmp
      nvim-lspconfig
      nvim-surround
      nvim-treesitter.withAllGrammars
      oil-nvim
      onedark-nvim
      precognition-nvim
      rainbow-delimiters-nvim
      telescope-nvim
      telescope-ui-select-nvim
      trouble-nvim
      vim-tmux-navigator
      which-key-nvim
    ];
  };
}
