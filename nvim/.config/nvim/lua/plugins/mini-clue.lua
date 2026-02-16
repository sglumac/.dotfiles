return {
  "echasnovski/mini.clue",
  version = false,
  config = function()
    local miniclue = require('mini.clue')

    miniclue.setup({
      triggers = {
        -- { mode = 'n', keys = '<C-w>' },
        { mode = 'n', keys = '<C-w>' },
        { mode = 'n', keys = '<leader>d,' },
        { mode = 'n', keys = '<leader>' },
      },

      clues = {
        {
          mode = 'n',
          -- keys = { '<C-w>', group = 'Window Hydra' },
          keys = { '<C-w>', group = 'Window Hydra' },
          desc = 'Window commands',
        },
        { mode = 'n', keys = '<C-w>h', postkeys = '<C-w>', action = '<C-w>h',  desc = 'move left' },
        { mode = 'n', keys = '<C-w>j', postkeys = '<C-w>', action = '<C-w>j',  desc = 'move down' },
        { mode = 'n', keys = '<C-w>k', postkeys = '<C-w>', action = '<C-w>k',  desc = 'move up' },
        { mode = 'n', keys = '<C-w>l', postkeys = '<C-w>', action = '<C-w>l',  desc = 'move right' },
        { mode = 'n', keys = '<C-w>H', postkeys = '<C-w>', action = '<C-w><',  desc = 'decrease width' },
        { mode = 'n', keys = '<C-w>J', postkeys = '<C-w>', action = '<C-w>-',  desc = 'decrease height' },
        { mode = 'n', keys = '<C-w>K', postkeys = '<C-w>', action = '<C-w>+',  desc = 'increase height' },
        { mode = 'n', keys = '<C-w>L', postkeys = '<C-w>', action = '<C-w>>',  desc = 'increase width' },
        { mode = 'n', keys = '<C-w>=', postkeys = '<C-w>', action = '<C-w>=',  desc = 'equalize windows' },
        { mode = 'n', keys = '<C-w>v', postkeys = '<C-w>', action = '<C-w>=',  desc = 'split vertical' },
        { mode = 'n', keys = '<C-w>s', postkeys = '<C-w>', action = '<C-w>=',  desc = 'split horizontal' },
        { mode = 'n', keys = '<C-w>q', action = '<Esc>',       desc = 'exit window/hydra' },
        {
          mode = 'n',
          keys = { '<leader>d,', group = 'Debug Hydra' },
          desc = 'Debug commands',
        },
        { mode = 'n', keys = '<leader>d,o', postkeys = '<leader>d,', action = function() require('dap').step_out() end,  desc = 'step out' },
        { mode = 'n', keys = '<leader>d,n', postkeys = '<leader>d,', action = function() require('dap').step_over() end, desc = 'step over' },
        { mode = 'n', keys = '<leader>d,k', postkeys = '<leader>d,', action = function() require('dap').step_back() end, desc = 'step back' },
        { mode = 'n', keys = '<leader>d,s', postkeys = '<leader>d,', action = function() require('dap').step_into() end, desc = 'step into' },
        {
          mode = 'n',
          keys = '<leader>d,b',
          postkeys = '<leader>d,',
          action = function()
            require('dap')
                .toggle_breakpoint()
          end,
          desc = 'toggle breakpoint'
        },
        {
          mode = 'n',
          keys = '<leader>d,t',
          postkeys = '<leader>d,',
          action = function()
            require('dap')
                .clear_breakpoints()
          end,
          desc = 'clear breakpoints'
        },
        { mode = 'n', keys = '<leader>d,c', postkeys = '<leader>d,', action = function() require('dap').continue() end,  desc = 'continue' },
        { mode = 'n', keys = '<leader>d,x', postkeys = '<leader>d,', action = function() require('dap').terminate() end, desc = 'terminate' },
        { mode = 'n', keys = '<leader>d,r', postkeys = '<leader>d,', action = function() require('dap').repl.open() end, desc = 'open repl' },
        { mode = 'n', keys = '<leader>d,q', action = '<Esc>',        desc = 'exit hydra' },
      },
    })
  end,
}
