---local capabilities = require("cmp_nvim_lsp").default_capabilities()
---local lspconfig = require("lspconfig")
---local helpers = require("electro.lsp.helpers")
---
---lspconfig.clangd.setup({
---})
---
---require("crates").setup({
---  lsp = {
---    enabled = true,
---    on_attach = helpers.default,
---    actions = true,
---    completion = true,
---    hover = true,
---  },
---})
local helpers = require("electro.lsp.helpers")
vim.lsp.config.clangd = {
  cmd = {
    'clangd',
    --'--clang-tidy',
    '--background-index',
    --'--offset-encoding=utf-8',
  },
  root_markers = { '.clangd', 'compile_commands.json' },
  filetypes = { 'c', 'cpp' },
  on_attach = helpers.default
}
vim.lsp.enable('clangd')
