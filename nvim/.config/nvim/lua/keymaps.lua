-- General keymaps
vim.keymap.set('n', ']d', '<cmd>DiagnosticNext<CR>', { desc = 'Next Diagnostic' })
vim.keymap.set('n', '[d', '<cmd>DiagnosticPrev<CR>', { desc = 'Previous Diagnostic' })
vim.keymap.set('n', '<leader>ud', '<cmd>DiagnosticToggle<CR>', { desc = 'Toggle diagnostics' })
vim.keymap.set('n', '<leader>yd', '<cmd>DiagnosticYank<CR>', { desc = 'Copy diagnostic to clipboard' })

vim.keymap.set('i', 'kj', '<Esc>', { noremap = true, silent = true, desc = 'Exit insert mode' })
vim.keymap.set('t', 'kj', [[<C-\><C-n>]], { noremap = true, silent = true, desc = 'Exit terminal mode' })

vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Copy to clipboard' })
vim.keymap.set('n', '<leader>p', '"+p', { noremap = true, silent = true, desc = 'Paste from clipboard' })
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save buffer' })
vim.keymap.set('n', '<leader>wq', '<cmd>wq<CR>', { desc = 'Save and close buffer' })
vim.keymap.set('n', '<leader>x', '<cmd>q!<CR>', { desc = 'Quit without saving' })
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit current window' })
vim.keymap.set('n', '<leader><Tab>', '<cmd>tabnew<CR>', { desc = 'Open new tab' })
vim.keymap.set('n', '<leader>qa', '<cmd>qa<CR>', { desc = 'Quit all windows' })
vim.keymap.set('n', '<leader>my', '<cmd>YankMessages<CR>', { desc = 'Copy last message to clipboard' })
vim.keymap.set('n', '<leader>py', '<cmd>YankFilePath<CR>', { desc = 'Copy file path to clipboard' })
vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = 'Rename symbol' })
vim.keymap.set('n', '<leader>nl', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
vim.keymap.set('n', '<leader>ve', '<cmd>ToggleVirtualEdit<CR>', { desc = 'Toggle virtualedit' })

-- LSP keymaps
vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = 'Code Action' })
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = 'Go to Definition' })
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = 'Hover' })
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = 'References' })

-- Debug mappings
vim.keymap.set('n', '<leader>db', '<cmd>DapToggleBreakpoint<CR>', { desc = 'Toggle Breakpoint' })
vim.keymap.set('n', '<leader>do', '<cmd>DapStepOut<CR>', { desc = 'Step Out' })
vim.keymap.set('n', '<leader>dn', '<cmd>DapStepOver<CR>', { desc = 'Step Over' })
vim.keymap.set('n', '<leader>ds', '<cmd>DapStepInto<CR>', { desc = 'Step Into' })
vim.keymap.set('n', '<leader>dt', '<cmd>DapClearBreakpoints<CR>', { desc = 'Clear Breakpoints' })
vim.keymap.set('n', '<leader>dc', '<cmd>DapContinue<CR>', { desc = 'Continue' })
vim.keymap.set('n', '<leader>dq', '<cmd>DapTerminate<CR>', { desc = 'Terminate' })
vim.keymap.set('n', '<leader>du', '<cmd>DapStackUp<CR>', { desc = 'Stack Up' })
vim.keymap.set('n', '<leader>dd', '<cmd>DapStackDown<CR>', { desc = 'Stack Down' })
vim.keymap.set('n', '<leader>df', '<cmd>Telescope dap configurations<CR>', { desc = 'Debug Configurations' })
vim.keymap.set('n', '<leader>dr', '<cmd>DapRunLast<CR>', { desc = 'Re/Start Last Config' })

-- Buffer keymaps (barbar)
for i = 1, 9 do
  vim.keymap.set('n', '<leader>b' .. i, '<cmd>BufferGoto ' .. i .. '<CR>',
    { silent = true, desc = 'Go to buffer ' .. i })
end
vim.keymap.set('n', '<leader>b0', '<cmd>BufferLast<CR>', { desc = 'Go to last buffer' })

vim.keymap.set('n', '<leader>b]', '<cmd>BufferNext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>b[', '<cmd>BufferPrevious<CR>', { desc = 'Previous buffer' })

vim.keymap.set('n', '<leader>bf', '<cmd>Telescope buffers<CR>', { desc = 'List Buffers' })

vim.keymap.set('n', '<leader>bo', '<cmd>BufferCloseAllButCurrent<CR>', { desc = 'Close all other buffers' })
vim.keymap.set('n', '<leader>bp', '<cmd>BufferCloseAllButPinned<CR>', { desc = 'Close all non-pinned' })
vim.keymap.set('n', '<leader>bn', '<cmd>BufferPin<CR>', { desc = 'Pin buffer' })
vim.keymap.set('n', '<leader>bq', '<cmd>BufferClose<CR>', { desc = 'Close buffer' })

-- Aerial keymaps
vim.keymap.set('n', '<leader>ar', '<cmd>AerialToggle<CR>', { desc = 'Toggle Aerial outline' })
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope aerial<CR>', { desc = 'Symbol find' })

-- Format keymap
vim.keymap.set('n', '<leader>ft', '<cmd>lua vim.lsp.buf.format()<CR>', { desc = 'Format buffer' })

-- Telescope keymaps
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>', { desc = 'Check Diagnostics' })
vim.keymap.set('n', '<leader>fq', '<cmd>Telescope quickfix<CR>', { desc = 'Check Quickfix' })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'Help Tags' })
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope lsp_references<CR>', { desc = 'LSP References' })
vim.keymap.set('n', '<leader>fw', '<cmd>Telescope grep_string<CR>', { desc = 'Grep Word Under Cursor' })
vim.keymap.set('n', '<leader>fz', '<cmd>Telescope grep_string search="" only_sort_text=true<CR>',
  { desc = 'Fuzzy Search' })
vim.keymap.set('n', '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<CR>',
  { desc = 'Fuzzy Search Current Buffer' })
vim.keymap.set('n', '<leader>fc', '<cmd>Telescope commands<CR>', { desc = 'Commands' })
vim.keymap.set('n', '<leader>fk', '<cmd>Telescope keymaps<CR>', { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>fH', '<cmd>Telescope highlights<CR>', { desc = 'Highlight Groups' })
vim.keymap.set('n', '<leader>fm', '<cmd>Telescope marks<CR>', { desc = 'Marks' })
vim.keymap.set('n', '<leader>fj', '<cmd>Telescope jumplist<CR>', { desc = 'Jumplist' })

-- Neo-tree keymaps
vim.keymap.set('n', '<leader>nt', '<cmd>Neotree reveal current<CR>', { desc = 'Full-width Neo-tree' })
vim.keymap.set('n', '<leader>o', '<cmd>Neotree focus<CR>', { desc = 'Focus Neo-tree' })

-- ToggleTerm keymaps
vim.keymap.set('n', '<F4>', '<cmd>ToggleTerm<CR>', { desc = 'Toggle floating terminal' })

-- Auto-session keymaps
vim.keymap.set('n', '<leader>ss', '<cmd>Telescope session-lens<CR>', { desc = 'Find Session' })

-- Trouble keymaps
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xq', '<cmd>Trouble qflist toggle<CR>', { desc = 'Quickfix (Trouble)' })
vim.keymap.set('n', '<leader>xl', '<cmd>Trouble loclist toggle<CR>', { desc = 'Location List (Trouble)' })
