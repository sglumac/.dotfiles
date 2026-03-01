return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup({
        defaults = {
          path_display = { "truncate" },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-x>"] = actions.close,
              ["<ESC>"] = actions.close,
              ["<CR>"] = actions.select_default + actions.center,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            },
            n = {
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["q"] = actions.close,
            }
          },
          prompt_prefix = "🔍 ",
          selection_caret = "➤ ",
          entry_prefix = "  ",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              preview_width = 0.55,
              results_width = 0.8,
              preview_cutoff = 1,
            },
            vertical = {
              mirror = false,
              preview_cutoff = 1,
            },
            width = 0.9,
            height = 0.9,
          },
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            ".cache",
            "__pycache__",
            "*.pyc",
            "*.o",
            "*.a",
            "*.out",
            "*.class",
          },
          winblend = 10,
          border = true,
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            hidden = true,
          },
          live_grep = {
            only_sort_text = true,
            additional_args = function()
              return { "--hidden" }
            end,
          },
          buffers = {
            sort_lastused = true,
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
              }
            }
          },
          lsp_references = {
            show_line = false,
          },
          lsp_document_symbols = {
            show_line = true,
            symbol_width = 50,
            fname_width = 50,
          },
          grep_string = {
            only_sort_text = true,
          },
          current_buffer_fuzzy_find = {},
          help_tags = {},
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    'LukasPietzschmann/telescope-tabs',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('telescope-tabs').setup({
        show_preview = true,
      })
    end,
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("dap")
    end
  }
}
