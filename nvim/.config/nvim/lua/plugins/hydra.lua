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

    local dap = require('dap')
    local hint = [[
     ^ ^Step^ ^ ^      ^ ^     Action
 ----^-^-^-^--^-^----  ^-^-------------------
     ^ ^back^ ^ ^     ^_t_: toggle breakpoint
     ^ ^ _K_^ ^        _T_: clear breakpoints
 out _H_ ^ ^ _L_ into  _c_: continue
     ^ ^ _J_ ^ ^       _x_: terminate
     ^ ^over ^ ^     ^^_r_: open repl

     ^ ^  _q_: exit
]]
    require('hydra') {
      name = 'Debug',
      hint = hint,
      config = {
        color = 'pink',
        invoke_on_body = true,
        hint = {
          type = 'window'
        },
      },
      mode = { 'n' },
      body = '<leader>d,',
      heads = {
        { 'o', dap.step_out,          { desc = 'step out' } },
        { 'n', dap.step_over,         { desc = 'step over' } },
        { 'k', dap.step_back,         { desc = 'step back' } },
        { 's', dap.step_into,         { desc = 'step into' } },
        { 'b', dap.toggle_breakpoint, { desc = 'toggle breakpoint' } },
        { 't', dap.clear_breakpoints, { desc = 'clear breakpoints' } },
        { 'c', dap.continue,          { desc = 'continue' } },
        { 'x', dap.terminate,         { desc = 'terminate' } },
        { 'r', dap.repl.open,         { exit = true, desc = 'open repl' } },
        { 'q', nil,                   { exit = true, nowait = true, desc = 'exit' } },
      }
    }
  end,
}
