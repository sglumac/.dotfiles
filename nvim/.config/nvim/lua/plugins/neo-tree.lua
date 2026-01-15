return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>nt", "<cmd>Neotree reveal current<CR>", desc = "Full-width Neo-tree" },
    { "<leader>o",  "<cmd>Neotree focus<CR>",  desc = "Focus Neo-tree" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",

      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        follow_current_file = {
          enabled = true,
        },
        group_empty_dirs = true,
        hijack_netrw_behavior = "open_default",
      },
      window = {
        auto_expand_width = true,
        width = 32,
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
        },
      },
      buffers = {
        follow_current_file = true,
      },
      git_status = {
        window = {
          position = "float",
        },
      },
    })
  end,
}
