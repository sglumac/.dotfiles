return {
  "akinsho/toggleterm.nvim",
  config = true,
  cmd = "ToggleTerm",
  keys = {
    { "<F4>", "<cmd>ToggleTerm<cr>", desc = "Toggle floating terminal" }
  },
  opts = {
    open_mapping = [[<F4>]],
    direction = "float",
    shade_filetypes = {},
    hide_numbers = true,
    insert_mappings = true,
    terminal_mappings = true,
    start_in_insert = true,
    close_on_exit = true,
    float_opts = {
      border = "curved",
      width = function()
          return math.ceil(vim.o.columns * 0.9)
      end,
      height = function()
          return math.ceil(vim.o.lines * 0.8)
      end,
      winblend = 10,
    },
  },
}
