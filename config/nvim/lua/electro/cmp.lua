local cmp = require("cmp")

local formatting = { format = require("lspkind").cmp_format(), }

local nvim_lsp = {
  name = "nvim_lsp",
  option = {
    markdown_oxide = {
      keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
    },
  },
}

local ls = require "luasnip"
ls.config.set_config {
  history = false,
  updateevents = "TextChanged,TextChangedI",
}

-- ---@diagnostic disable-next-line:redundant-parameter
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  formatting = formatting,
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.insert,
      select = true,
    },

    --['<CR>'] = cmp.mapping(function(fallback)
    --  if cmp.visible() then
    --    if luasnip.expandable() then
    --      luasnip.expand()
    --    else
    --      cmp.confirm({
    --        select = true,
    --      })
    --    end
    --  else
    --    fallback()
    --  end
    --end),

    ["<Tab>"] = cmp.mapping(function(fallback)
      -- ["<c-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    nvim_lsp,
    { name = "buffer",  max_item_count = 5, }, -- text within current buffer
    { name = "path",    max_item_count = 3, }, -- file system paths
    { name = "luasnip", max_item_count = 3, }, -- snippets
    -- { name = "hledger", },
  }),
  experimental = {
    ghost_text = true,
  },
})

require("luasnip.loaders.from_vscode").lazy_load()
-- require("luasnip.loaders.from_vscode").load()


-- vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
-- vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
-- vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

-- vim.keymap.set({ "i", "s" }, "<C-E>", function()
--   if ls.choice_active() then
--     ls.change_choice(1)
--   end
-- end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true }
)

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true }
)
