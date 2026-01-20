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
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- IMPORTANT: Enable background indexing by removing =false
      -- Add other useful clangd flags for better performance
      lspconfig.clangd.setup({
        cmd = {
          "clangd",
          "--background-index",           -- ENABLED: Allows indexing in background
          "--clang-tidy",                 -- Enable clang-tidy diagnostics
          "--completion-style=detailed",  -- Better completion info
          "--header-insertion=never",     -- Don't auto-insert headers
          "--pch-storage=memory",         -- Store precompiled headers in memory
        },
        capabilities = capabilities,
        -- Set filetypes explicitly (optional but good practice)
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        -- Optional: Single file support for standalone files
        single_file_support = true,
      })

      -- Lua LS configuration
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- CMake configuration
      lspconfig.cmake.setup({
        capabilities = capabilities,
        filetypes = { "cmake" },
      })

      -- Pyright configuration (only once)
      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- Global LSP keybindings (apply to all buffers with LSP)
      vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', 
        { noremap = true, silent = true, desc = "Code Action" })
      vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', 
        { noremap = true, silent = true, desc = "Go to Definition" })
      vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', 
        { noremap = true, silent = true, desc = "Hover" })
      vim.api.nvim_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', 
        { noremap = true, silent = true, desc = "References" })
      vim.api.nvim_set_keymap('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', 
        { noremap = true, silent = true, desc = "Rename" })
      vim.api.nvim_set_keymap('n', '<leader>d', '<Cmd>lua vim.diagnostic.open_float()<CR>', 
        { noremap = true, silent = true, desc = "Show Diagnostics" })
      vim.api.nvim_set_keymap('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', 
        { noremap = true, silent = true, desc = "Previous Diagnostic" })
      vim.api.nvim_set_keymap('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', 
        { noremap = true, silent = true, desc = "Next Diagnostic" })
      
      -- Better diagnostic configuration
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- Sign column configuration
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },
}

