{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    # nvim-plugs/cmp.nix
    nvim-plugs/default.nix
  ];

  home.packages = with pkgs; [
    # Faster grep, like silver searcher (ag)
    ripgrep
  ];
  # programs.neovim = {
  #   enable = true;
  # };

  programs.nixvim = {
    enable = true;
    # Select the colorscheme
    colorschemes.catppuccin.enable = true;

    globals.mapleader = ",";

    # Use same clipboard as system
    clipboard.register = "unnamedplus";

    # Set options (listed with :h option-list)
    opts = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers

      shiftwidth = 2;        # Tab width should be 2
      smarttab = true;
      expandtab = true;
      # These two go together
      ignorecase = true;
      smartcase = true;
      # I believe this can actually be annoying
      smartindent = false;
      # This one is fine though
      autoindent = true;

      undofile = true;
      # Proper word wrapping in soft wrap mode
      linebreak = true;
      # Allow project-specific .vimrc files, but restrict commands to secure ones
      exrc = true;
      secure = true;
      # Always keep some lines above or below the cursor when at the top or bot
      scrolloff = 3;
    };

    # Keymaps
    keymaps = [
      {
        key = "<leader> ";
        action = "<cmd>noh<CR>";
        mode = "n";
      }
      {
        key = "n";
        action = "nzz";
        mode = "n";
      }
      {
        key = "N";
        action = "Nzz";
        mode = "n";
      }
      {
        key = "<C-BS>";
        action = "<C-w>";
        mode = "i";
      }
      {
        key = "<leader>w";
        action = "<cmd>vsplit<CR><C-w>l";
        mode = "n";
      }
      {
        key = "<C-l>";
        action = "<C-w>l";
        mode = "n";
      }
      {
        key = "<C-k>";
        action = "<C-w>k";
        mode = "n";
      }
      {
        key = "<C-j>";
        action = "<C-w>j";
        mode = "n";
      }
      {
        key = "<C-h>";
        action = "<C-w>h";
        mode = "n";
      }
      {
        key = "<leader>n";
        action = "<cmd>bn<CR>";
        mode = "n";
      }
      {
        key = "<leader>p";
        action = "<cmd>bp<CR>";
        mode = "n";
      }
    ];

    # Plugins
    plugins = {
      web-devicons.enable = true;
      # Telescope (find files and text in files)
      telescope = {
        enable = true;
	extensions = {
	  # Fuzzy finder extension
	  fzf-native = {
            enable = true;
            settings = {
              case_mode = "smart_case";
              fuzzy = true;
              override_file_sorter = true;
              override_generic_sorter = true;
            };
          };
	};
        keymaps = {
          # Example usages:
          # "<C-p>" = {
          #   action = "git_files";
          #   options = {
          #     desc = "Telescope Git Files";
          #   };
          # };
          # "<leader>fg" = "live_grep";
          # "<leader>sg" = "live_grep";
          # "<leader>sf" = "find_files";
          "<leader>sh" = {
            action = "help_tags";
            options = {
              desc = "[S]earch [H]elp";
            };
          };
          "<leader>sk" = {
            action = "keymaps";
            options = {
              desc = "[S]earch [K]eymaps";
            };
          };
          "<leader>sf" = {
            action = "find_files";
            options = {
              desc = "[S]earch [F]iles";
            };
          };
          "<leader>ss" = {
            action = "builtin";
            options = {
              desc = "[S]earch [S]elect Telescope";
            };
          };
          "<leader>sw" = {
            action = "grep_string";
            options = {
              desc = "[S]earch current [W]ord";
            };
          };
          "<leader>sg" = {
            action = "live_grep";
            options = {
              desc = "[S]earch by [G]rep";
            };
          };
          "<leader>sd" = {
            action = "diagnostics";
            options = {
              desc = "[S]earch [D]iagnostics";
            };
          };
          "<leader>sr" = {
            action = "resume";
            options = {
              desc = "[S]earch [R]esume";
            };
          };
          # TODO: Sort out how to do this, since the '.' is a problem
          # "<leader>s." = {
          #   action = "oldfiles";
          #   options = {
          #     desc = "[S]earch Recent Files ("." for repeat)";
          #   };
          # };
          "<leader><leader>" = {
            action = "buffers";
            options = {
              desc = "[ ] Find existing buffers";
            };
          };
        }; # End keymaps
      }; # End telescope

      # Lightline - Nice status bars
      lightline = {
        enable = true;
        # colorscheme = "gruvbox";
        settings.colorscheme = null;
      };

      # Programming Language Parser, a must-have
      treesitter.enable = true;
      # Creates whole chunks of code for you.
      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
        };
        fromVscode = [
          {
            lazyLoad = true;
            paths = "${pkgs.vimPlugins.friendly-snippets}";
          }
        ];
      };
    };
  };

}

