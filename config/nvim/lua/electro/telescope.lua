local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local telescope = require("telescope")

local mappings = {
  ["<C-2>"] = actions.select_horizontal,
  ["<C-5>"] = actions.select_vertical,
  ['<C-">'] = actions.select_horizontal,
  ["<C-%>"] = actions.select_vertical,
  ["<C-v>"] = false,
  ["<C-x>"] = false,
}

local mappings_for_modes = {
  n = mappings,
  i = mappings,
}

--  set internal mappings for telescope
telescope.setup({
  pickers = {
    find_files = { mappings = mappings_for_modes, },
    live_grep = { mappings = mappings_for_modes, },
    buffers = { mappings = mappings_for_modes, },
  },
})

telescope.load_extension("ui-select")

WK.add({
  { "<leader>s",  group = "search", },
  { "<leader>sf", builtin.find_files, desc = "search file by name", },
  { "<leader>sg", builtin.live_grep,  desc = "search file by content (rg)", },
  { "<leader>sb", builtin.buffers,    desc = "search buffer by name", },
  { "<leader>sh", builtin.help_tags,  desc = "open help", },
  { "<leader>sx", builtin.commands,   desc = "run command (M-x)", },
})
