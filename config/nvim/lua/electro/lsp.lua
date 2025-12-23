require("lspconfig")
vim.lsp.enable("lua_ls")        -- Lua
vim.lsp.enable("clangd")        -- C/C++
vim.lsp.enable("rust_analyzer") -- Rust
vim.lsp.enable("marksman")      -- Markdown
vim.lsp.enable("nixd")          -- Nix

local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    rust = { "rustfmt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    nix = { "nixfmt" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true, -- Use LSP if no formatter is found
  },
})

local keymap = vim.keymap

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }

    opts.desc = "Show LSP references"
    keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

    opts.desc = "Go to declaration"
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    opts.desc = "Go to definition"
    keymap.set("n", "gd", vim.lsp.buf.definition, opts)

    opts.desc = "Show LSP implementations"
    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

    opts.desc = "Show LSP type definitions"
    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

    opts.desc = "See available code actions"
    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

    opts.desc = "Smart rename"
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    opts.desc = "Show buffer diagnostics"
    keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics<CR>", opts)

    opts.desc = "Show line diagnostics"
    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

    opts.desc = "Go to previous diagnostic"
    keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, opts)

    opts.desc = "Go to next diagnostic"
    keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, opts)

    opts.desc = "Show documentation under cursor"
    keymap.set("n", "gh", vim.lsp.buf.hover, opts)

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

    vim.keymap.set("n", "<leader>f", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, opts)
  end
})

-- Is this necessary?
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  callback = function()
    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    vim.lsp.config("*", {
      capabilities = capabilities,
    })
  end
})

local severity = vim.diagnostic.severity

vim.diagnostic.config({
  signs = {
    text = {
      [severity.ERROR] = " ",
      [severity.WARN] = " ",
      [severity.HINT] = "󰠠 ",
      [severity.INFO] = " ",
    },
  },
})
