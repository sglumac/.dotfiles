return {
  "echasnovski/mini.clue",
  version = false,
  config = function()
    local miniclue = require('mini.clue')

    miniclue.setup({
      triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<leader>' },
        { mode = 'x', keys = '<leader>' },
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
        { mode = 'n', keys = '<C-w>w',        postkeys = '<C-w>',                 desc = 'move next' },
        { mode = 'n', keys = '<C-w><',        postkeys = '<C-w>',                 desc = 'decrease width' },
        { mode = 'n', keys = '<C-w>-',        postkeys = '<C-w>',                 desc = 'decrease height' },
        { mode = 'n', keys = '<C-w>+',        postkeys = '<C-w>',                 desc = 'increase height' },
        { mode = 'n', keys = '<C-w>>',        postkeys = '<C-w>',                 desc = 'increase width' },

        -- Leader keys (general)
        { mode = 'n', keys = '<leader>y',     desc = 'copy to clipboard' },
        { mode = 'n', keys = '<leader>p',     desc = 'paste from clipboard' },
        { mode = 'n', keys = '<leader>w',     desc = 'save buffer' },
        { mode = 'n', keys = '<leader>wq',    desc = 'save and close' },
        { mode = 'n', keys = '<leader>x',     desc = 'quit without saving' },
        { mode = 'n', keys = '<leader>q',     desc = 'quit window' },
        { mode = 'n', keys = '<leader>qa',    desc = 'quit all windows' },
        { mode = 'n', keys = '<leader><Tab>', desc = 'open new tab' },
        { mode = 'n', keys = '<leader>nl',    desc = 'clear search highlight' },
        { mode = 'n', keys = '<leader>ud',    desc = 'toggle diagnostics' },
        { mode = 'n', keys = '<leader>yd',    desc = 'copy diagnostic' },
        { mode = 'n', keys = '<leader>my',    desc = 'copy last message' },
        { mode = 'n', keys = '<leader>py',    desc = 'copy file path' },
        { mode = 'n', keys = '<leader>ve',    desc = 'toggle virtualedit' },

        -- Leader + b + number (buffer jump)
        { mode = 'n', keys = '<leader>b1',    postkeys = '<leader>b', desc = 'go to buffer 1' },
        { mode = 'n', keys = '<leader>b2',    postkeys = '<leader>b', desc = 'go to buffer 2' },
        { mode = 'n', keys = '<leader>b3',    postkeys = '<leader>b', desc = 'go to buffer 3' },
        { mode = 'n', keys = '<leader>b4',    postkeys = '<leader>b', desc = 'go to buffer 4' },
        { mode = 'n', keys = '<leader>b5',    postkeys = '<leader>b', desc = 'go to buffer 5' },
        { mode = 'n', keys = '<leader>b6',    postkeys = '<leader>b', desc = 'go to buffer 6' },
        { mode = 'n', keys = '<leader>b7',    postkeys = '<leader>b', desc = 'go to buffer 7' },
        { mode = 'n', keys = '<leader>b8',    postkeys = '<leader>b', desc = 'go to buffer 8' },
        { mode = 'n', keys = '<leader>b9',    postkeys = '<leader>b', desc = 'go to buffer 9' },
        { mode = 'n', keys = '<leader>b0',    postkeys = '<leader>b', desc = 'go to last buffer' },

        -- Leader + b (buffers)
        { mode = 'n', keys = '<leader>b]',    postkeys = '<leader>b', desc = 'next buffer' },
        { mode = 'n', keys = '<leader>b[',    postkeys = '<leader>b', desc = 'previous buffer' },
        { mode = 'n', keys = '<leader>bo',    desc = 'close all other buffers' },
        { mode = 'n', keys = '<leader>bp',    desc = 'close non-pinned' },
        { mode = 'n', keys = '<leader>bn',    desc = 'pin buffer' },
        { mode = 'n', keys = '<leader>bq',    desc = 'close buffer' },
        { mode = 'n', keys = '<leader>bf',    desc = 'list buffers' },

        -- Leader + c (code)
        { mode = 'n', keys = '<leader>ca',    desc = 'code action' },

        -- Leader + d (debug)
        { mode = 'n', keys = '<leader>do',    postkeys = '<leader>d',             desc = 'step out' },
        { mode = 'n', keys = '<leader>dn',    postkeys = '<leader>d',             desc = 'step over' },
        { mode = 'n', keys = '<leader>ds',    postkeys = '<leader>d',             desc = 'step into' },
        { mode = 'n', keys = '<leader>dc',    postkeys = '<leader>d',             desc = 'continue' },
        { mode = 'n', keys = '<leader>du',    postkeys = '<leader>d',             desc = 'stack up' },
        { mode = 'n', keys = '<leader>dd',    postkeys = '<leader>d',             desc = 'stack down' },
        { mode = 'n', keys = '<leader>dr',    postkeys = '<leader>d',             desc = 're/start last config' },
        { mode = 'n', keys = '<leader>db',    desc = 'toggle breakpoint' },
        { mode = 'n', keys = '<leader>dt',    desc = 'clear breakpoints' },
        { mode = 'n', keys = '<leader>dq',    desc = 'terminate' },
        { mode = 'n', keys = '<leader>df',    desc = 'debug configurations' },

        -- Leader + f (find/format/file tree)
        { mode = 'n', keys = '<leader>ff',    desc = 'find files' },
        { mode = 'n', keys = '<leader>fd',    desc = 'check diagnostics' },
        { mode = 'n', keys = '<leader>fq',    desc = 'check quickfix' },
        { mode = 'n', keys = '<leader>fg',    desc = 'live grep' },
        { mode = 'n', keys = '<leader>fh',    desc = 'help tags' },
        { mode = 'n', keys = '<leader>fr',    desc = 'lsp references' },
        { mode = 'n', keys = '<leader>fw',    desc = 'grep word' },
        { mode = 'n', keys = '<leader>fz',    desc = 'fuzzy search' },
        { mode = 'n', keys = '<leader>/',     desc = 'fuzzy search buffer' },
        { mode = 'n', keys = '<leader>fc',    desc = 'commands' },
        { mode = 'n', keys = '<leader>fk',    desc = 'keymaps' },
        { mode = 'n', keys = '<leader>fH',    desc = 'highlight groups' },
        { mode = 'n', keys = '<leader>fm',    desc = 'marks' },
        { mode = 'n', keys = '<leader>fj',    desc = 'jumplist' },
        { mode = 'n', keys = '<leader>fs',    desc = 'symbol find' },
        { mode = 'n', keys = '<leader>ft',    desc = 'format buffer' },

        -- Leader + n (neo-tree)
        { mode = 'n', keys = '<leader>nt',             desc = 'full-width neo-tree' },

        -- Leader + o (files/open)
        { mode = 'n', keys = '<leader>o',             desc = 'focus neo-tree' },

        -- Leader + s (sessions)
        { mode = 'n', keys = '<leader>ss',             desc = 'find session' },

        -- Leader + x (trouble/diagnostics)
        { mode = 'n', keys = '<leader>xx',             desc = 'diagnostics (trouble)' },
        { mode = 'n', keys = '<leader>xq',             desc = 'quickfix (trouble)' },
        { mode = 'n', keys = '<leader>xl',             desc = 'location list (trouble)' },

        -- Leader + a (aerial)
        { mode = 'n', keys = '<leader>ar',             desc = 'toggle aerial outline' },

        -- Leader + r (refactor/rename)
        { mode = 'n', keys = '<leader>rn',             desc = 'rename symbol' },

        -- Single key bindings (no leader)
        { mode = 'n', keys = '[',             desc = 'previous (diagnostic/item)' },
        { mode = 'n', keys = ']',             desc = 'next (diagnostic/item)' },
        { mode = 'n', keys = 'gd',            desc = 'go to definition' },
        { mode = 'n', keys = 'gr',            desc = 'show references' },
        { mode = 'n', keys = 'K',             desc = 'hover' },
        { mode = 'n', keys = '<F4>',          desc = 'toggle floating terminal' },
      },
    })
  end,
}
