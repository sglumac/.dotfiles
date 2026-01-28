return {
  "stevearc/aerial.nvim",
  config = function()
    require("aerial").setup({
      backends = { "lsp", "treesitter", "markdown" },
      filter_kind = false,
      layout = {
        default_direction = "right",
        max_width = math.floor(vim.o.columns * 0.5),
      },
      enter_on_toggle = true,
      autojump = true,
      close_on_select = true,
      show_guides = true,
    })

    vim.keymap.set("n", "<leader>ar", "<cmd>AerialToggle<CR>", { desc = "Toggle Aerial outline" })
    vim.keymap.set("n", '<leader>fs', '<cmd>Telescope aerial<CR>', { desc = "Symbol find" })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lspconfig",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
  }
}

