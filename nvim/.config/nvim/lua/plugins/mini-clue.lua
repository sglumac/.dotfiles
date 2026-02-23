return {
  "echasnovski/mini.clue",
  version = false,
  config = function()
    -- Debug mappings
    local dap = require('dap')
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>do', dap.step_out, { desc = 'Step Out' })
    vim.keymap.set('n', '<leader>dn', dap.step_over, { desc = 'Step Over' })
    vim.keymap.set('n', '<leader>ds', dap.step_into, { desc = 'Step Into' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dt', dap.clear_breakpoints, { desc = 'Clear Breakpoints' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue' })
    vim.keymap.set('n', '<leader>dq', dap.terminate, { desc = 'Terminate' })
    vim.keymap.set('n', '<leader>du', dap.up, { desc = 'Stack Up' })
    vim.keymap.set('n', '<leader>dd', dap.down, { desc = 'Stack Down' })
    vim.keymap.set("n", "<leader>df", "<cmd>Telescope dap configurations<CR>", { desc = "Debug Configurations" })

    local miniclue = require('mini.clue')

    miniclue.setup({
      triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },
        -- Windows
        { mode = 'n', keys = '<C-w>' },
        -- Debug
        { mode = 'n', keys = '<leader>d' },
        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },
        -- Built-in commands (g, z, etc.)
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
        -- Others
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'n', keys = '[' },
        { mode = 'n', keys = ']' },
      },

      clues = {
        -- Defaults
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.z(),
        -- Windows
        miniclue.gen_clues.windows(),
        { mode = 'n', keys = '<C-w>w',     postkeys = '<C-w>',                                action = '<C-w>w',            desc = 'move next' },
        { mode = 'n', keys = '<C-w><',     postkeys = '<C-w>',                                action = '<C-w><',            desc = 'decrease width' },
        { mode = 'n', keys = '<C-w>-',     postkeys = '<C-w>',                                action = '<C-w>-',            desc = 'decrease height' },
        { mode = 'n', keys = '<C-w>+',     postkeys = '<C-w>',                                action = '<C-w>+',            desc = 'increase height' },
        { mode = 'n', keys = '<C-w>>',     postkeys = '<C-w>',                                action = '<C-w>>',            desc = 'increase width' },
        -- Debug
        { mode = 'n', keys = '<leader>do', postkeys = '<leader>d',                            action = dap.step_out,        desc = 'step out' },
        { mode = 'n', keys = '<leader>dn', postkeys = '<leader>d',                            action = dap.step_over,       desc = 'step over' },
        { mode = 'n', keys = '<leader>ds', postkeys = '<leader>d',                            action = dap.step_into,       desc = 'step into' },
        { mode = 'n', keys = '<leader>dc', postkeys = '<leader>d',                            action = dap.continue,        desc = 'continue' },
        { mode = 'n', keys = '<leader>du', postkeys = '<leader>d',                            action = dap.up,              desc = 'stack up' },
        { mode = 'n', keys = '<leader>dd', postkeys = '<leader>d',                            action = dap.down,            desc = 'stack down' },
        { mode = 'n', keys = '<leader>db', action = dap.toggle_breakpoint,                    desc = 'toggle breakpoint' },
        { mode = 'n', keys = '<leader>dt', action = dap.clear_breakpoints,                    desc = 'clear breakpoints' },
        { mode = 'n', keys = '<leader>dq', action = dap.terminate,                            desc = 'terminate' },
        { mode = 'n', keys = '<leader>df', action = "<cmd>Telescope dap configurations<CR>",  desc = 'debug configurations' },
      },
    })
  end,
}
