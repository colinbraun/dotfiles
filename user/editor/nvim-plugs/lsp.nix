{ ... }:
{
  programs.nixvim = {
    plugins = {
      # Autoformat on write for LSPs that support it
      lsp-format = {enable = true;};
      # Provides symbols for autocomplete (fields, methods, etc.)
      # Change lspkind.mode to only show text, symbols, or both (default)
      lspkind = {
        enable = true;
        mode = "symbol";
      };
      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true; # Lua
          clangd.enable = true; # C/C++
          nil_ls.enable = true; # Nix
          eslint.enable = true;
          html.enable = true; # HTML
          marksman.enable = true; # Markdown
          pyright.enable = true; # Python
          gopls.enable = true; # Go
          ts_ls.enable = false; # Typescript
          yamlls.enable = true; # YAML
          bashls.enable = true; # Bash
          zls.enable = true; # Zig
        };
        keymaps = {
          silent = true;
          lspBuf = {
            gd = {
              action = "definition";
              desc = "Goto Definition";
            };
            gr = {
              action = "references";
              desc = "Goto References";
            };
            gD = {
              action = "declaration";
              desc = "Goto Declaration";
            };
            gI = {
              action = "implementation";
              desc = "Goto Implementation";
            };
            gT = {
              action = "type_definition";
              desc = "Type Definition";
            };
            K = {
              action = "hover";
              desc = "Hover";
            };
            "<leader>cw" = {
              action = "workspace_symbol";
              desc = "Workspace Symbol";
            };
            "<leader>cr" = {
              action = "rename";
              desc = "Rename";
            };
          };
          diagnostic = {
            "<leader>cd" = {
              action = "open_float";
              desc = "Line Diagnostics";
            };
            "[d" = {
              action = "goto_next";
              desc = "Next Diagnostic";
            };
            "]d" = {
              action = "goto_prev";
              desc = "Previous Diagnostic";
            };
          };
        };
      };
    };
    extraConfigLua = ''
      local _border = "rounded"

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = _border
        }
      )

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = _border
        }
      )

      vim.diagnostic.config{
        float={border=_border}
      };

      require('lspconfig.ui.windows').default_options = {
        border = _border
      }
    '';
  };
}

