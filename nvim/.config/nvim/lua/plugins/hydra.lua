return {
  "anuvyklack/hydra.nvim",
  config = function()
    local Hydra = require('hydra')
    Hydra({
      name = 'Window Navigation',
      hint = [[
  Window Nav: _h_ ←  _j_ ↓  _k_ ↑  _l_ →  _q_: Close  _<Esc>_: Exit
  ]],
      config = { color = 'blue', hint = { border = 'single' }, timeout = 500 },
      mode = 'n',
      body = '<leader>w',
      heads = {
        { 'h',     '<C-w>h', { exit = false }  },
        { 'j',     '<C-w>j', { exit = false }  },
        { 'k',     '<C-w>k', { exit = false }  },
        { 'l',     '<C-w>l', { exit = false }  },
        { 'q',     '<C-w>c', { exit = false }  },
        { '<Esc>', nil,     { exit = true } },
      }
    })
  end,
}
