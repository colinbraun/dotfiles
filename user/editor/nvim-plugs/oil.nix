{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.oil = {
      enable = true;
      settings = {
        useDefaultKeymaps = true;
        deleteToTrash = true;
        float = {
          padding = 2;
          maxWidth = 0; # ''math.ceil(vim.o.lines * 0.8 - 4)'';
          maxHeight = 0; # ''math.ceil(vim.o.columns * 0.8)'';
          border = "rounded"; # 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
          winOptions = {
            winblend = 0;
          };
        };
        preview = {
          border = "rounded";
        };
        # keymaps.__raw = ''{ ["<C-p>"] = "actions.preview", opts = { vertical = true, split = "belowright" } }'';
        kemaps = {
          "g?" = "actions.show_help";
          "<CR>" = "actions.select";
          "<C-s>" = "actions.select_vsplit";
          "<C-h>" = false;
          "<M-h>" = "actions.select_split";
          "<C-t>" = "actions.select_tab";
          "<C-p>" = ''"actions.select", opts = { vertical = true, split = "belowright" }'';
          "<C-c>" = "actions.close";
          "<C-l>" = "actions.refresh";
          "-" = "actions.parent";
          "_" = "actions.open_cwd";
          "`" = "actions.cd";
          "~" = "actions.tcd";
          "gs" = "actions.change_sort";
          "gx" = "actions.open_external";
          "g." = "actions.toggle_hidden";
          "g\\" = "actions.toggle_trash";
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "-";
        action = ":Oil<CR>";
        options = {
          desc = "Open parent directory";
          silent = true;
        };
      }
    ];

    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons
    ];
  };
  
}

