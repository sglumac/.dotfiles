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
      vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DiagnosticInfo' })
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
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        virt_text_pos = "right_align",
        all_frames = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
        show_stop_reason = true,
        commented = true,
        only_first_definition = false,
        -- all_references = true,
        clear_on_continue = false,
      })
    end,
  },
}
