return {
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      bar = {
        update_debounce = 50,
        padding = { left = 2, right = 2, },
      },
      icons = { enable = true },
    },
  },
}
