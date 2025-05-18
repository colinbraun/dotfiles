-- stylua: ignore start
vim.o.mouse = "a"                -- allow mouse everywhere
vim.o.tabstop = 2                -- \
vim.o.softtabstop = 2            -- |
vim.o.shiftwidth = 2             -- > Set tab behaviour
vim.o.expandtab = true           -- /
vim.o.autoindent = true          -- Auto indent
vim.o.colorcolumn = "80,100,120" -- set column markers
vim.o.signcolumn = "yes"         -- always show signcolumn
vim.o.number = true              -- always show line numbers
vim.o.relativenumber = false     -- vim poeple seem to love it, I don't. Explicit disable to be save against changes in the default
vim.o.cursorline = true          -- slightly color the line the cursor is on
vim.o.cursorcolumn = true        -- slightly color the column the cursor is on
vim.o.clipboard = "unnamedplus"  -- yank/delete into system clipboard
vim.o.list = true
--vim.o.listchars = "tab:⇢⇥,trail:⎵,eol:↩"
vim.o.listchars = "tab:⇢⇥,trail:⎵"
vim.o.wrap = true
vim.o.ignorecase = true
vim.o.smartcase = true
-- stylua: ignore end

vim.g.mapleader = "," -- set `<leader>` to the comma key

-- VIM KEYBINDS
-- Clear highlights on search
vim.keymap.set('n', '<leader><space>', '<cmd>nohlsearch<cr>')
-- Create new vertical split
vim.keymap.set('n', '<leader>w', '<cmd>vsplit<cr><c-w>l')
-- Next buffer
vim.keymap.set('n', '<leader>n', '<cmd>bnext<cr>')
-- Previous buffer
vim.keymap.set('n', '<leader>p', '<cmd>bprevious<cr>')
-- Tmux navigation (depends on tmux navigator being installed
vim.keymap.set('n', "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>")
vim.keymap.set('n', "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>")
vim.keymap.set('n', "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>")
vim.keymap.set('n', "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>")
vim.keymap.set('n', "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>")
vim.keymap.set('n', ";", ":")
vim.keymap.set('i', "jj", "<Esc>")

-- Set up indent markers
require("ibl").setup({
  indent = { char = "┊", },
  scope = { enabled = true, },
})
