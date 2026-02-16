return {
  "echasnovski/mini.clue",
  version = false,
  config = function()
    local miniclue = require('mini.clue')

    miniclue.setup({
      triggers = {
        { mode = 'n', keys = '<C-w>' },
        { mode = 'n', keys = '<leader>d' },
        { mode = 'n', keys = '<leader>' },
      },

      clues = {
        -- Window Hydra
        {
          mode = 'n',
          keys = { '<C-w>', group = 'Window Hydra' },
          desc = 'Window commands',
        },
        { mode = 'n', keys = '<C-w>h', postkeys = '<C-w>', action = '<C-w>h',         desc = 'move left' },
        { mode = 'n', keys = '<C-w>j', postkeys = '<C-w>', action = '<C-w>j',         desc = 'move down' },
        { mode = 'n', keys = '<C-w>k', postkeys = '<C-w>', action = '<C-w>k',         desc = 'move up' },
        { mode = 'n', keys = '<C-w>l', postkeys = '<C-w>', action = '<C-w>l',         desc = 'move right' },
        { mode = 'n', keys = '<C-w>H', postkeys = '<C-w>', action = '<C-w><',         desc = 'decrease width' },
        { mode = 'n', keys = '<C-w>J', postkeys = '<C-w>', action = '<C-w>-',         desc = 'decrease height' },
        { mode = 'n', keys = '<C-w>K', postkeys = '<C-w>', action = '<C-w>+',         desc = 'increase height' },
        { mode = 'n', keys = '<C-w>L', postkeys = '<C-w>', action = '<C-w>>',         desc = 'increase width' },
        { mode = 'n', keys = '<C-w>=', postkeys = '<C-w>', action = '<C-w>=',         desc = 'equalize windows' },
        { mode = 'n', keys = '<C-w>v', postkeys = '<C-w>', action = '<C-w>=',         desc = 'split vertical' },
        { mode = 'n', keys = '<C-w>s', postkeys = '<C-w>', action = '<C-w>=',         desc = 'split horizontal' },
        { mode = 'n', keys = '<C-w>q', action = '<Esc>',   desc = 'exit window/hydra' },
        -- Debug Hydra
        {
          mode = 'n',
          keys = { '<leader>d', group = 'Debug Hydra' },
          desc = 'Debug commands',
        },
        { mode = 'n', keys = '<leader>do', postkeys = '<leader>d', action = function() require('dap').step_out() end,  desc = 'step out' },
        { mode = 'n', keys = '<leader>dn', postkeys = '<leader>d', action = function() require('dap').step_over() end, desc = 'step over' },
        { mode = 'n', keys = '<leader>dk', postkeys = '<leader>d', action = function() require('dap').step_back() end, desc = 'step back' },
        { mode = 'n', keys = '<leader>ds', postkeys = '<leader>d', action = function() require('dap').step_into() end, desc = 'step into' },
        {
          mode = 'n',
          keys = '<leader>db',
          postkeys = '<leader>d',
          action = function()
            require('dap')
                .toggle_breakpoint()
          end,
          desc = 'toggle breakpoint'
        },
        {
          mode = 'n',
          keys = '<leader>dt',
          postkeys = '<leader>d',
          action = function()
            require('dap')
                .clear_breakpoints()
          end,
          desc = 'clear breakpoints'
        },
        { mode = 'n', keys = '<leader>dc', postkeys = '<leader>d', action = function() require('dap').continue() end,  desc = 'continue' },
        { mode = 'n', keys = '<leader>dx', postkeys = '<leader>d', action = function() require('dap').terminate() end, desc = 'terminate' },
        { mode = 'n', keys = '<leader>dr', postkeys = '<leader>d', action = function() require('dap').repl.open() end, desc = 'open repl' },
        { mode = 'n', keys = '<leader>dq', action = '<Esc>',        desc = 'exit hydra' },
      },
    })
  end,
}
