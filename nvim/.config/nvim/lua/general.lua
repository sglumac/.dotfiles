-- Set the leader key to ' '
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Enables reading .nvim.lua in project root
vim.opt.exrc = true
vim.opt.secure = true

-- Diagnostic view
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
    focusable = false,
  },
})

-- Set tabs to 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- Use spaces instead of tab characters
vim.opt.softtabstop = 2

-- General Neovim settings
vim.opt.number = true -- Enable line numbers

-- Color scheme
vim.opt.termguicolors = true
vim.opt.background = "light"
vim.opt.cursorline = true

-- Disable swap files
vim.opt.swapfile = false

-- Auto-detect external file changes
vim.api.nvim_create_augroup("AutoCheckTime", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = "AutoCheckTime",
  pattern = "*",
  command = "silent! checktime",
})

vim.api.nvim_create_autocmd({ "FocusLost", "WinLeave" }, {
  group = "AutoCheckTime",
  pattern = "*",
  command = "silent! checktime",
})

-- Make folds open by default
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Wrap
vim.o.wrap = true

