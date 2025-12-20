return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'clangd', 'lua_ls', 'cmake', 'pyright' },
        automatic_installation = true,
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    config = function()
      local lspconfig = require('lspconfig')
      local clangdcapabilities = require('cmp_nvim_lsp').default_capabilities()
      clangdcapabilities.offsetEncoding = { "utf-8" }

      vim.lsp.config('clangd', {
        cmd = {
          "clangd",
          "--background-index=false",  -- Disables background indexing to prevent excessive memory usage
          "--log=verbose",             -- Increases verbosity for debugging
        },
        capabilities = clangdcapabilities,
      })

      vim.lsp.enable('pyright')
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('cmake')
      vim.lsp.enable('pyright')

      -- Set keybinding for applying LSP code actions
      vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
    end,
  },
}

