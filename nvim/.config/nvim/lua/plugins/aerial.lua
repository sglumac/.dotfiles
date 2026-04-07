return {
  "stevearc/aerial.nvim",
  config = function()
    require("aerial").setup({
      backends = { "lsp", "treesitter", "markdown" },
      filter_kind = { -- :help SymbolKind
        -- High-level
        "Module", "Namespace",
        -- Types
        "Class", "Struct", "Interface", "Enum", "TypeParameter", "TypeAlias",
        -- Callables
        "Function", "Method", "Constructor",
        -- Data
        -- "Field", "Property", "Constant", "EnumMember", "Variable",
        -- Optional
        -- "Event", "Operator",
      },
      layout = {
        default_direction = "right",
        max_width = math.floor(vim.o.columns * 0.5),
      },
      enter_on_toggle = true,
      autojump = true,
      close_on_select = true,
      show_guides = true,
      manage_folds = true,
      link_folds_to_tree = true,
      link_tree_to_folds = true,
      open_folds_automatically = true,
    })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lspconfig",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
  }
}
