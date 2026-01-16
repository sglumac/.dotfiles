return {
  'Mofiqul/vscode.nvim',
  priority = 1000,
  config = function()
    -- Set the global background to light
    vim.o.background = 'light'

    -- Configure and load the theme
    require('vscode').setup({
      -- Alternatively, you can set the style here:
      -- style = 'light'
      italic_comments = true, -- Enable italic comments (optional)
      disable_nvimtree_bg = true, -- Prevents background color in nvim-tree (optional)
    })
    vim.cmd.colorscheme('vscode')
  end,
}

