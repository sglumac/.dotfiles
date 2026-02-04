return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb" },
        automatic_installation = true,
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require('dap')

      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          command = vim.fn.stdpath('data') .. '/mason/bin/codelldb', -- Ensure this is the correct path to codelldb installed by Mason
          args = { "--port", "${port}" },
        }
      }

      -- Example for .nvim.lua: Debug Configuration for C++ files
      -- dap.configurations.cpp = {
      --   {
      --     name = 'Launch C++ Program',
      --     type = 'codelldb',        -- Matches the adapter name defined above
      --     request = 'launch',       -- Launch mode
      --     program = function()
      --       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      --     end,
      --     cwd = '${workspaceFolder}',  -- Current directory where the program will run
      --     stopOnEntry = false,         -- Whether to stop at the entry point of the program
      --     args = {},                   -- Command-line arguments to the program
      --     runInTerminal = false,
      --   },
      -- }

      vim.keymap.set('n', '<F5>', ':lua require("dap").continue()<CR>',
        { desc = "Start debugging", noremap = true, silent = true })
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint,
        { desc = "Set a breakpoint", noremap = true, silent = true })
      vim.keymap.set("n", "<leader>de", function() dap.set_exception_breakpoints({ "raise" }); end,
        { desc = "Break on all exceptions", noremap = true, silent = true })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup({
        layouts = {
          {
            elements = { -- Side bar
              { id = "scopes",      size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks",      size = 0.25 },
              { id = "watches",     size = 0.25 },
            },
            position = "left",
            size = 40,
          },
          {
            elements = { -- Bottom bar
              { id = "repl",    size = 0.5 },
              { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 10,
          },
        },
      })
      vim.keymap.set('n', '<leader>du', dapui.toggle,
        { desc = "Open or close the DAP UI", noremap = true, silent = true })
      vim.keymap.set('n', '<leader>ds', function() dapui.float_element("scopes") end,
        { desc = "Open DAP UI Scopes", noremap = true, silent = true })

      local keymaps = {
        ['c'] = { command = dap.continue, description = "Continue debugging" },
        ['n'] = { command = dap.step_over, description = "Step over a function" },
        ['s'] = { command = dap.step_into, description = "Step insto a function" },
        ['fin'] = { command = dap.step_out, description = "Step out of a function" },
        ['q'] = { command = dap.terminate, description = "Stop debugging" },
        ['u'] = { command = dap.up, description = "Up one frame" },
        ['d'] = { command = dap.down, description = "Down one frame" },
      }

      local debug_keymaps_active = false

      local function set_debug_keymaps()
        for keymap, info in pairs(keymaps) do
          print("Adding ", keymap)
          vim.keymap.set('n', keymap, info.command, { desc = info.description, noremap = true, silent = true })
        end
        debug_keymaps_active = true
      end

      local function remove_debug_keymaps()
        if not debug_keymaps_active then
          return
        end
        for keymap, _ in pairs(keymaps) do
          print("Removing ", keymap)
          vim.keymap.del('n', keymap)
        end
        debug_keymaps_active = false
      end

      dap.listeners.before.attach.dapui_config = function()
        dapui.open(); set_debug_keymaps()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open(); set_debug_keymaps()
      end
      dap.listeners.after.event_initialized.dapui_config = function()
        dapui.open(); set_debug_keymaps()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close(); remove_debug_keymaps()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close(); remove_debug_keymaps()
      end
    end,
  },
}
