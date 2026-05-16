WK = require("which-key")

---A small helper function to require a submodule "relatively"
---@param submodule string
---@return unknown
local function rs(submodule)
  return require('electro' .. "." .. submodule)
end

rs("cmp")        -- foundations for completions
rs("git")        -- set up neogit (kind of magit)
rs("lsp")        -- LSP and related setup
rs("lualine")    -- Set up the status bar at the bottom
rs("markdown")   -- Set up markdown editing
rs("misc")       -- miscelanous editor settings
rs("nabla")      -- set up and load nabla (nice maths)
rs("noice")      -- setup noice for nicer notifications and messages
rs("oil")        -- manage files as if it was a text buffer
rs("rainbow")    -- set up rainbow parenthesis
rs("surround")   -- gelps with surrounding in parens or quotes
rs("telescope")  -- some fuzzy finders
rs("theme")      -- how shall everything look like
rs("treesitter") -- set up treesitter
rs("trouble")    -- load trouble
rs("whichkey")   -- set up whichkey, which provides help as you type
rs("autopairs")
rs("harpoon")
