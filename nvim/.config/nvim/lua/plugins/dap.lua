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
    dependencies = { "anuvyklack/hydra.nvim" },
    config = function()
      local dap = require('dap')

      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
          args = { "--port", "${port}" },
        }
      }

      -- Example for .nvim.lua: Debug Configuration for C++ files
      -- dap.configurations.cpp = {
      --   {
      --     name = 'Launch C++ Program',
      --     type = 'codelldb',
      --     request = 'launch',
      --     program = function()
      --       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      --     end,
      --     cwd = '${workspaceFolder}',
      --     stopOnEntry = false,
      --     args = {},
      --     runInTerminal = false,
      --   },
      -- }

      -- Keep only essential non-hydra keymaps
      vim.keymap.set('n', '<F5>', dap.continue,
        { desc = "Start debugging", noremap = true, silent = true })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "anuvyklack/hydra.nvim"
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes",      size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks",      size = 0.25 },
              { id = "watches",     size = 0.25 },
            },
            position = "left",
            size = 40,
          },
          {
            elements = {
              { id = "repl",    size = 0.5 },
              { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 10,
          },
        },
      })

      -- ==============================================
      -- MAIN DEBUG HYDRA
      -- ==============================================
      local Hydra = require('hydra')

      local debug_hint = [[
  DEBUG MODE ────────────────────────────────────────
  _c_: Continue/Run        _q_: Stop/terminate
  _n_: Step Over           _s_: Step Into
  _o_: Step Out            _r_: Restart

  Breakpoints:
  _b_: Toggle Breakpoint   _B_: Clear All Breakpoints
  _e_: Exception Breakpt   _p_: Conditional Breakpt

  UI & Navigation:
  _u_: Toggle DAP UI       _U_: Toggle REPL
  _w_: Watch Expression    _v_: Variables/Scopes
  _st_: Stack Trace        _f_: Focus Frame

  _<Esc>_: Exit Debug Mode   _?_: Help
  ]]

      local debug_hydra = Hydra({
        name = 'Debug Mode',
        hint = debug_hint,
        config = {
          color = 'pink',
          invoke_on_body = true,
          timeout = false, -- Stay active until explicitly exited
          hint = {
            border = 'rounded',
            position = 'middle-right',
            offset = 0,
          },
        },
        mode = 'n',
        body = '<Leader>d',
        heads = {
          -- Execution control
          { 'c', dap.continue,          { desc = 'Continue/Run', exit = false } },
          { 'q', dap.terminate,         { desc = 'Stop debugging', exit = false } },
          { 'r', dap.restart,           { desc = 'Restart debug session', exit = false } },

          -- Stepping
          { 'n', dap.step_over,         { desc = 'Step Over', exit = false } },
          { 's', dap.step_into,         { desc = 'Step Into', exit = false } },
          { 'o', dap.step_out,          { desc = 'Step Out', exit = false } },

          -- Breakpoints
          { 'b', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint', exit = false } },
          { 'B', dap.clear_breakpoints, { desc = 'Clear All Breakpoints', exit = false } },
          { 'e', function() dap.set_exception_breakpoints({ "raise" }) end,
            { desc = 'Exception Breakpoint', exit = false } },
          { 'p', function()
            local condition = vim.fn.input('Breakpoint condition: ')
            if condition and condition ~= '' then
              dap.set_breakpoint(condition)
            end
          end, { desc = 'Conditional Breakpoint', exit = false } },

          -- UI & Navigation
          { 'u', dapui.toggle,    { desc = 'Toggle DAP UI', exit = false } },
          { 'U', dap.repl.toggle, { desc = 'Toggle REPL', exit = false } },
          { 'w', function()
            local expr = vim.fn.input('Watch expression: ')
            if expr and expr ~= '' then
              dapui.widgets.hover(expr)
            end
          end, { desc = 'Watch Expression', exit = false } },
          { 'v', function() dapui.float_element("scopes") end,
            { desc = 'Variables/Scopes', exit = false } },
          { 'st', function() dapui.float_element("stacks") end,
            { desc = 'Stack Trace', exit = false } },
          { 'f', function() dapui.float_element() end,
            { desc = 'Focus Current Frame', exit = false } },

          -- Frame navigation
          { 'u',     dap.up,              { desc = 'Up Stack Frame', exit = false } },
          { 'd',     dap.down,            { desc = 'Down Stack Frame', exit = false } },

          -- Exit
          { '<Esc>', nil,                 { exit = true, desc = 'Exit Debug Mode' } },
          { '?',     ':help dap.txt<CR>', { exit = false, desc = 'DAP Help' } },
        }
      })

      -- ==============================================
      -- QUICK DEBUG ACTIONS HYDRA (For common tasks)
      -- ==============================================
      local quick_debug_hint = [[
  QUICK DEBUG ──────────────────────────────────────
  _1_: Run/Continue      _2_: Toggle Breakpoint
  _3_: Step Over         _4_: Step Into
  _5_: Open UI           _6_: Close UI

  _<Esc>_: Exit
  ]]

      Hydra({
        name = 'Quick Debug',
        hint = quick_debug_hint,
        config = {
          color = 'red',
          invoke_on_body = true,
          timeout = 3000, -- 3 seconds timeout
          hint = {
            border = 'single',
            position = 'bottom-right',
          },
        },
        mode = 'n',
        body = '<Leader>dq',
        heads = {
          { '1',     dap.continue,          { desc = 'Run', exit = false } },
          { '2',     dap.toggle_breakpoint, { desc = 'Toggle BP', exit = false } },
          { '3',     dap.step_over,         { desc = 'Step Over', exit = false } },
          { '4',     dap.step_into,         { desc = 'Step Into', exit = false } },
          { '5',     dapui.open,            { desc = 'Open UI', exit = false } },
          { '6',     dapui.close,           { desc = 'Close UI', exit = false } },
          { '<Esc>', nil,                   { exit = true } },
        }
      })

      -- ==============================================
      -- DAP UI SPECIFIC HYDRA
      -- ==============================================
      local ui_hint = [[
  DAP UI ──────────────────────────────────────────
  _t_: Toggle Main UI     _r_: Toggle REPL
  _s_: Scopes Float       _w_: Watches Float
  _b_: Breakpoints Float  _st_: Stack Trace Float
  _c_: Console Float      _h_: Help

  _<Esc>_: Exit
  ]]

      Hydra({
        name = 'DAP UI',
        hint = ui_hint,
        config = {
          color = 'teal',
          hint = { border = 'rounded', position = 'bottom' },
        },
        mode = 'n',
        body = '<Leader>du',
        heads = {
          { 't', dapui.toggle,    { desc = 'Toggle UI', exit = false } },
          { 'r', dap.repl.toggle, { desc = 'Toggle REPL', exit = false } },
          { 's', function() dapui.float_element("scopes") end,
            { desc = 'Scopes', exit = false } },
          { 'w', function() dapui.float_element("watches") end,
            { desc = 'Watches', exit = false } },
          { 'b', function() dapui.float_element("breakpoints") end,
            { desc = 'Breakpoints', exit = false } },
          { 'st', function() dapui.float_element("stacks") end,
            { desc = 'Stack Trace', exit = false } },
          { 'c', function() dapui.float_element("console") end,
            { desc = 'Console', exit = false } },
          { 'h',     ':help dapui.txt<CR>', { desc = 'UI Help', exit = false } },
          { '<Esc>', nil,                   { exit = true } },
        }
      })

      -- Auto-show UI on debug start
      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open
      dap.listeners.after.event_initialized.dapui_config = dapui.open
      dap.listeners.before.event_terminated.dapui_config = dapui.close
      dap.listeners.before.event_exited.dapui_config = dapui.close
    end,
  },
}
