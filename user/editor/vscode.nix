{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      # Absolutely want
      vscodevim.vim
      llvm-vs-code-extensions.vscode-clangd
      mkhl.direnv

      # Not sure
      eamodio.gitlens
      yzhang.markdown-all-in-one
      dracula-theme.theme-dracula
    ];
  };
}
