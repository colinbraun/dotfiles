local capabilities = require("cmp_nvim_lsp").default_capabilities()
local helpers = require("electro.lsp.helpers")

require("lspconfig").ts_ls.setup({
  on_attach = helpers.keymap,
  capabilities = capabilities,
})
