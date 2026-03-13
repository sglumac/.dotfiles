return {
  {
    'saghen/blink.cmp',
    version = '*',
    opts = {
      keymap = {
        preset = 'none',
        ['<C-Space>'] = { 'show', 'fallback' },
        ['<C-e>']     = { 'hide', 'fallback' },
        ['<CR>']      = { 'accept', 'fallback' },
        ['<C-j>']     = { 'select_next', 'fallback' },
        ['<C-k>']     = { 'select_prev', 'fallback' },
        ['<C-w>']     = { 'scroll_documentation_up', 'fallback' },
        ['<C-s>']     = { 'scroll_documentation_down', 'fallback' },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
  },
}

