{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lua-language-server
    nixd
    nixfmt-rfc-style
    ripgrep # Faster grep, like silver searcher (ag)
  ];

  programs.neovim = {
    enable = true;
    withRuby = false;
    plugins = with pkgs.vimPlugins; [
      cmp-nvim-lsp
      cmp_luasnip
      conform-nvim
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
