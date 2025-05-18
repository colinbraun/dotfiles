local lualine = require("lualine")

lualine.setup({
  theme = "onedark",
  sections = {
    lualine_c = {
      {
        "filename",
        path = 1, -- Show Relative path. Default only shows filename.
      }
    },
  },
})
