return {
  "anuvyklack/hydra.nvim",
  lazy = true,
  keys = { "<leader>w", "<leader>d" },
  config = function()
    local hydra = require("hydra")

    hydra({
      name = "Window Hydra",
      mode = "n",
      body = "<leader>w",
      heads = {
        { "h", "<C-w>h", { desc = "move left" } },
        { "j", "<C-w>j", { desc = "move down" } },
        { "k", "<C-w>k", { desc = "move up" } },
        { "l", "<C-w>l", { desc = "move right" } },
        { "H", "<C-w><", { desc = "decrease width" } },
        { "J", "<C-w>-", { desc = "decrease height" } },
        { "K", "<C-w>+", { desc = "increase height" } },
        { "L", "<C-w>>", { desc = "increase width" } },
        { "=", "<C-w>=", { desc = "equalize windows" } },
        { "q", nil,      { exit = true, desc = "quit hydra" } },
      },
    })

    hydra({
      name = "Debug Hydra",
      mode = "n",
      body = "<leader>d",
      heads = {
        -- Execution control
        { "c", function() require("dap").continue() end,                             { desc = "continue" } },
        { "q", function() require("dap").terminate() end,                            { desc = "terminate" } }, -- Shift+Q
        { "r", function() require("dap").restart() end,                              { desc = "restart" } },

        -- Stepping
        { "n", function() require("dap").step_over() end,                            { desc = "step over" } },
        { "s", function() require("dap").step_into() end,                            { desc = "step into" } },
        { "O", function() require("dap").step_out() end,                             { desc = "step out" } }, -- Shift+O

        -- Breakpoints
        { "b", function() require("dap").toggle_breakpoint() end,                    { desc = "toggle breakpoint" } },
        { "B", function() require("dap").clear_breakpoints() end,                    { exit = true, desc = "clear all breakpoints" } },
        { "e", function() require("dap").set_exception_breakpoints({ "raise" }) end, { desc = "exception breakpoint" } },
        { "p", function()
          local cond = vim.fn.input("Breakpoint condition: ")
          if cond and cond ~= "" then
            require("dap").set_breakpoint(cond)
          end
        end, { desc = "conditional breakpoint" } },

        -- Frame navigation
        { "u", require("dap").up,       { desc = "up frame" } },
        { "d", require("dap").down,     { desc = "down frame" } },

        -- DAP UI
        { "o", require("dapui").open,   { desc = "open UI" } },
        { "x", require("dapui").close,  { desc = "close UI" } },
        { "t", require("dapui").toggle, { desc = "toggle UI" } },
        { "?", function() vim.cmd("help dap.txt") end,   { desc = "help" } },
        { "q", nil,                                      { exit = true, desc = false } },
      },
    })

    -- --- Add more hydras here, each with a unique body key ---
    -- Example: Quickfix / Location list navigation
    -- Hydra({
    --   name = "Quickfix Hydra",
    --   mode = "n",
    --   body = "<leader>q",
    --   heads = {
    --     { "n", "<cmd>cnext<CR>", { desc = "next item" } },
    --     { "p", "<cmd>cprev<CR>", { desc = "previous item" } },
    --     { "<Esc>", nil, { exit = true, desc = false } },
    --   },
    --   config = { color = "blue", hint = true },
    -- })
  end,
}
