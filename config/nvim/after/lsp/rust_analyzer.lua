return {
  settings = {
    ["rust-analyzer"] = {
      -- Use clippy instead of standard cargo check
      check = {
        command = "clippy",
      },
      -- Enable cargo features automatically
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
      },
      -- Quality of life: Inlay hints
      inlayHints = {
        bindingModeHints = { enable = true },
        closureReturnTypeHints = { enable = "always" },
        lifetimeElisionHints = { enable = "skip_trivial" },
        parameterHints = { enable = true },
        typeHints = { enable = true },
      },
      procMacro = {
        enable = true,
      },
    },
  },
}
