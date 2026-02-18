return {
  {
    'nvim-treesitter/nvim-treesitter',
    tag = 'v0.9.3',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'c', 'cpp', 'lua', 'python', 'cmake' },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'nvim-treesitter/playground',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 1,
        trim_scope = "outer",
        mode = "cursor",
        separator = "─",
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "treesitter-context",
        callback = function()
          vim.opt_local.winheight = 1
          vim.opt_local.winminheight = 1
        end,
      })
    end,
  },
}
