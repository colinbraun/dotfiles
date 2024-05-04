{ ... }: {
  # Import all your configuration modules here
  imports = [
    # ./auto_cmd.nix
    # ./colors.nix
    # ./options.nix
    # ./custom_commands.nix
    # ./custom_keymappings.nix

    # Plugins / Features
    ./cmp.nix
    ./lsp.nix
    ./oil.nix
    ./simple-plugins.nix
    # ./copilot.nix
    # ./git.nix
    # ./languages.nix
    # ./linting.nix
    # ./lsp.nix
    # ./simple_plugins.nix
    # ./snippets.nix
    # ./statusline.nix
    # ./telescope.nix
    # ./tree.nix
    # ./treesitter.nix
    # ./which_key.nix
  ];
}
