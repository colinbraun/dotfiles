local capabilities = require("cmp_nvim_lsp").default_capabilities()
local helpers = require("electro.lsp.helpers")

require("lspconfig").nixd.setup({
  on_attach = helpers.keymap,
  capabilities = capabilities,
  cmd = { "nixd", },
  settings = {
    ["nixd"] = {
      nix = {
        binary = "nix",
        maxMemoryMB = nil,
        flake = {
          autoEvalInputs = false,
          autoArchive = false,
          nixpkgsInputName = nil,
        },
      },
      formatting = {
        command = { "nixfmt", "--", },
      },
    },
  },
})
