local dap = require('dap')

-- Helper function for DAP
local function start_last_config()
  local ft = vim.bo.filetype
  local configs = dap.configurations[ft]
  if not configs or #configs == 0 then
    return vim.notify("No DAP configurations for filetype: " .. ft, vim.log.levels.WARN)
  end
  local last = configs[#configs]
  dap.run(last)
end

-- General keymaps
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { noremap = true, silent = true, desc = 'Next Diagnostic' })
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { noremap = true, silent = true, desc = 'Previous Diagnostic' })
vim.keymap.set('n', '<leader>ud', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
  print('Diagnostics: ' .. (vim.diagnostic.is_enabled({ bufnr = 0 }) and 'ON' or 'OFF'))
end, { desc = 'Toggle diagnostics in current buffer' })
vim.keymap.set('n', '<leader>yd', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local diags = vim.diagnostic.get(bufnr, { lnum = row - 1 })
  if #diags == 0 then
    vim.notify("No diagnostics on this line", vim.log.levels.INFO)
    return
  end
  local text = diags[1].message
  vim.fn.setreg('+', text)
  vim.notify("Diagnostic copied to clipboard", vim.log.levels.INFO)
end, { desc = "Copy diagnostic under cursor to system clipboard" })

vim.keymap.set('i', 'kj', '<Esc>', { noremap = true, silent = true, desc = 'Exit insert mode' })
vim.keymap.set('t', 'kj', [[<C-\><C-n>]], { noremap = true, silent = true, desc = 'Exit terminal mode' })

vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Copy to clipboard' })
vim.keymap.set('n', '<leader>p', '"+p', { noremap = true, silent = true, desc = 'Paste from clipboard' })
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true, desc = 'Save buffer' })
vim.keymap.set('n', '<leader>wq', ':wq<CR>', { noremap = true, silent = true, desc = 'Save and close buffer' })
vim.keymap.set('n', '<leader>x', ':q!<CR>', { noremap = true, silent = true, desc = 'Quit without saving' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true, desc = 'Quit current window' })
vim.keymap.set('n', '<leader><Tab>', ':tabnew<CR>', { noremap = true, silent = true, desc = 'Open new tab' })
vim.keymap.set('n', '<leader>qa', ':qa<CR>', { noremap = true, silent = true, desc = 'Quit all windows' })
vim.keymap.set('n', '<leader>my', ':lua vim.fn.setreg("+", vim.fn.execute("messages"))<CR>',
  { noremap = true, silent = true, desc = 'Copy last message to clipboard' })
vim.keymap.set('n', '<leader>py', function()
  local path = vim.api.nvim_buf_get_name(0)
  vim.fn.setreg('+', path)
  print("Copied: " .. path)
end, { noremap = true, silent = true, desc = 'Copy file path to clipboard' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap = true, silent = true, desc = 'Rename symbol' })
vim.keymap.set('n', '<leader>nl', ':nohlsearch<CR>', { desc = 'Clear search highlight' })
vim.keymap.set("n", "<leader>ve", function()
  if vim.opt.virtualedit == "all" then
    vim.opt.virtualedit = ""
  else
    vim.opt.virtualedit = "all"
  end
end, { desc = "Toggle virtualedit" })

-- LSP keymaps
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code Action" })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to Definition" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Hover" })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true, silent = true, desc = "References" })

-- Debug mappings
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
vim.keymap.set('n', '<leader>do', dap.step_out, { desc = 'Step Out' })
vim.keymap.set('n', '<leader>dn', dap.step_over, { desc = 'Step Over' })
vim.keymap.set('n', '<leader>ds', dap.step_into, { desc = 'Step Into' })
vim.keymap.set('n', '<leader>dt', dap.clear_breakpoints, { desc = 'Clear Breakpoints' })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue' })
vim.keymap.set('n', '<leader>dq', dap.terminate, { desc = 'Terminate' })
vim.keymap.set('n', '<leader>du', dap.up, { desc = 'Stack Up' })
vim.keymap.set('n', '<leader>dd', dap.down, { desc = 'Stack Down' })
vim.keymap.set("n", "<leader>df", "<cmd>Telescope dap configurations<CR>", { desc = "Debug Configurations" })
vim.keymap.set('n', '<leader>dr', start_last_config, { desc = 'Re/Start Last Config' })

-- Buffer keymaps (barbar)
for i = 1, 9 do
  vim.keymap.set('n', '<leader>b' .. i, '<Cmd>BufferGoto ' .. i .. '<CR>',
    { silent = true, desc = 'Go to buffer ' .. i })
end
vim.keymap.set('n', '<leader>b0', '<Cmd>BufferLast<CR>', { silent = true, desc = 'Go to last buffer' })

vim.keymap.set('n', '<leader>b]', '<Cmd>BufferNext<CR>', { silent = true, desc = 'Next buffer' })
vim.keymap.set('n', '<leader>b[', '<Cmd>BufferPrevious<CR>', { silent = true, desc = 'Previous buffer' })

vim.keymap.set('n', '<leader>bf', '<cmd>Telescope buffers<CR>', { desc = "List Buffers" })

vim.keymap.set('n', '<leader>bo', '<Cmd>BufferCloseAllButCurrent<CR>',
  { silent = true, desc = 'Close all other buffers' })
vim.keymap.set('n', '<leader>bp', '<Cmd>BufferCloseAllButPinned<CR>',
  { silent = true, desc = 'Close all non-pinned' })
vim.keymap.set('n', '<leader>bn', '<Cmd>BufferPin<CR>', { silent = true, desc = 'Pin buffer' })
vim.keymap.set('n', '<leader>bq', '<Cmd>BufferClose<CR>', { silent = true, desc = 'Close buffer' })

-- Aerial keymaps
vim.keymap.set("n", "<leader>ar", "<cmd>AerialToggle<CR>", { desc = "Toggle Aerial outline" })
vim.keymap.set("n", '<leader>fs', '<cmd>Telescope aerial<CR>', { desc = "Symbol find" })

-- Format keymap
vim.keymap.set("n", "<leader>ft", vim.lsp.buf.format, { noremap = true, silent = true, desc = "Format buffer" })

-- Telescope keymaps
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = "Find Files" })
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>', { desc = "Check Diagnostics" })
vim.keymap.set('n', '<leader>fq', '<cmd>Telescope quickfix<CR>', { desc = "Check Quickfix" })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = "Live Grep" })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = "Help Tags" })
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope lsp_references<CR>', { desc = "LSP References" })
vim.keymap.set('n', '<leader>fw', '<cmd>Telescope grep_string<CR>', { desc = "Grep Word Under Cursor" })
vim.keymap.set('n', '<leader>fz', '<cmd>Telescope grep_string search="" only_sort_text=true<CR>',
  { desc = "Fuzzy Search" })
vim.keymap.set('n', '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<CR>',
  { desc = "Fuzzy Search Current Buffer" })
vim.keymap.set('n', '<leader>fc', '<cmd>Telescope commands<CR>', { desc = "Commands" })
vim.keymap.set('n', '<leader>fk', '<cmd>Telescope keymaps<CR>', { desc = "Keymaps" })
vim.keymap.set('n', '<leader>fH', '<cmd>Telescope highlights<CR>', { desc = "Highlight Groups" })
vim.keymap.set('n', '<leader>fm', '<cmd>Telescope marks<CR>', { desc = "Marks" })
vim.keymap.set('n', '<leader>fj', '<cmd>Telescope jumplist<CR>', { desc = "Jumplist" })

-- Neo-tree keymaps
vim.keymap.set('n', '<leader>nt', '<cmd>Neotree reveal current<CR>', { desc = "Full-width Neo-tree" })
vim.keymap.set('n', '<leader>o', '<cmd>Neotree focus<CR>', { desc = "Focus Neo-tree" })

-- ToggleTerm keymaps
vim.keymap.set('n', '<F4>', '<cmd>ToggleTerm<cr>', { desc = "Toggle floating terminal" })

-- Auto-session keymaps
vim.keymap.set('n', '<leader>ss', '<cmd>Telescope session-lens<cr>', { desc = "Find Session" })

-- Trouble keymaps
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = "Diagnostics (Trouble)" })
vim.keymap.set('n', '<leader>xq', '<cmd>Trouble qflist toggle<cr>', { desc = "Quickfix (Trouble)" })
vim.keymap.set('n', '<leader>xl', '<cmd>Trouble loclist toggle<cr>', { desc = "Location List (Trouble)" })
