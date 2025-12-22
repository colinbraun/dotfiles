local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local ls_sources = {
  -- formatting.stylua,
  formatting.rustfmt,
  formatting.alejandra,
  formatting.black,
  --code_actions.statix,
  --diagnostics.deadnix,
}

-- Enable null-ls
null_ls.setup({
  diagnostics_format = "[#{m}] #{s} (#{c})",
  debounce = 250,
  default_timeout = 5000,
  sources = ls_sources,
  on_attach = require("electro.lsp.helpers").default,
})

-- Enable lspconfig
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Load individual languages configuration
require("electro.lsp.astro")
require("electro.lsp.digestif")
require("electro.lsp.elixir")
require("electro.lsp.gleam")
require("electro.lsp.html")
require("electro.lsp.lua")
require("electro.lsp.mdx")
require("electro.lsp.nixd")
require("electro.lsp.oxide")
require("electro.lsp.pyright")
require("electro.lsp.rust")
require("electro.lsp.tailwind")
require("electro.lsp.typescript")
require("electro.lsp.zig")
require("electro.lsp.cpp")
