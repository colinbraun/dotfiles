local capabilites = require("cmp_nvim_lsp").default_capabilities()
local helpers = require("electro.lsp.helpers")

require("lspconfig").digestif.setup({
  on_attach = helpers.keymap,
  capabilites = capabilites,
})
