return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb", "python" },
        automatic_installation = true,
      })
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap                             = require('dap')

      -- Disable launch.json
      require('dap.ext.vscode').json_decode = function() return {} end


      -- C/C++: codelldb
      dap.adapters.codelldb  = {
        type = 'server',
        port = '${port}',
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        }
      }

      dap.configurations.cpp = {
        {
          name = 'Launch C/C++ Program',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
          runInTerminal = true,
          exceptionBreakpoints = { 'cpp_throw', 'cpp_catch' },
        },
      }
      dap.configurations.c   = dap.configurations.cpp

      vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DiagnosticWarn' })
      vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DiagnosticInfo' })
      vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DiagnosticInfo' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DiagnosticHint' })
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local adapter_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(adapter_python)

      require('dap').configurations.python = {
        {
          name = "Launch Python file",
          type = "python",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
          pythonPath = function()
            local cwd = vim.fn.getcwd()

            if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
              return cwd .. "/.venv/bin/python" -- Auto-detect .venv
            end

            if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
              return cwd .. "/venv/bin/python" -- Auto-detect venv
            end

            return "/usr/bin/python" -- fallback
          end,
          -- Debugpy (https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings)
          justMyCode = true,
          console = "integratedTerminal",
        },
      }
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local function set_dap_virtual_text_colors()
        vim.api.nvim_set_hl(0, "NvimDapVirtualTextChanged", {
          -- fg = "#bbbbbb", -- soft gray (barely visible on light themes)
          fg = "#d70000", -- bright red for visibility (good on light background)
          bg = "NONE",
          bold = true,
        })
        vim.api.nvim_set_hl(0, "NvimDapVirtualText", {
          fg = "#bbbbbb", -- soft gray (barely visible on light themes)
          bg = "NONE",
          italic = true,
        })
      end
      set_dap_virtual_text_colors()                -- Apply highlights immediately
      vim.api.nvim_create_autocmd("ColorScheme", { -- Reapply highlights whenever colorscheme changes
        callback = set_dap_virtual_text_colors,
      })
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        virt_text_pos = "inline",
        all_frames = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
        show_stop_reason = true,
        only_first_definition = false,
        all_references = true,
        clear_on_continue = false,
        commented = false,
      })
    end,
  },
}
