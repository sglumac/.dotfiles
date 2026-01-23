return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'clangd', 'lua_ls', 'neocmake', 'pyright' },
        automatic_installation = true,
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config.clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=never",
          "--pch-storage=memory",
        },
        capabilities = capabilities,
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        single_file_support = true,
      }

      vim.lsp.config.lua_ls = {
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
      }

      vim.lsp.config.neocmake = {
        capabilities = capabilities,
        filetypes = { "cmake" },
      }

      vim.lsp.config.pyright = {
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
      }

      vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true, desc = "Code Action" })
      vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true, desc = "Go to Definition" })
      vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true, desc = "Hover" })
      vim.api.nvim_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true, desc = "References" })
      vim.api.nvim_set_keymap('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true, desc = "Rename" })
      vim.api.nvim_set_keymap('n', '<leader>d', '<Cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true, desc = "Show Diagnostics" })
      vim.api.nvim_set_keymap('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true, desc = "Previous Diagnostic" })
      vim.api.nvim_set_keymap('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true, desc = "Next Diagnostic" })

      vim.diagnostic.config({
          virtual_text = true,
          signs = {
              Error = { text = "" },
              Warn  = { text = "" },
              Hint  = { text = "" },
              Info  = { text = "" },
          },
          underline = true,
          update_in_insert = false,
          severity_sort = true,
          float = {
              focusable = false,
              style = "minimal",
              border = "rounded",
              source = true,
              header = "",
              prefix = "",
          },
      })

      vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", numhl = "" })
      vim.fn.sign_define("DiagnosticSignWarn",  { text = "", texthl = "DiagnosticSignWarn", numhl = "" })
      vim.fn.sign_define("DiagnosticSignHint",  { text = "", texthl = "DiagnosticSignHint", numhl = "" })
      vim.fn.sign_define("DiagnosticSignInfo",  { text = "", texthl = "DiagnosticSignInfo", numhl = "" })

    end,
  },
}

