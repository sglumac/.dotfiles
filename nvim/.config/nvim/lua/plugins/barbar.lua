return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    animation = true,
    auto_hide = false,
    tabpages = true,
    clickable = true,
  },
  config = function(_, opts)
    require('barbar').setup(opts)

    vim.keymap.set('n', '<Tab>', '<Cmd>BufferNext<CR>', { silent = true })
    vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', { silent = true })
  end,

}
