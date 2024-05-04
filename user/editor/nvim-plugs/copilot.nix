{ ... }:
{
  programs.nixvim = {
    plugins.copilot-lua = {
      enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ct";
        action = "<cmd>lua require(\"copilot.suggestion\").toggle_auto_trigger();<CR>";
        options = {
          desc = "Toggle automatic Copilot suggestions";
          noremap = false;
        };
      }
    ];
  };
}

