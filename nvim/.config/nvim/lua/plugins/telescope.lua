 return {
  {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'}, {'nvim-tree/nvim-web-devicons'} },
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = "Find Files" },
      { '<leader>fg', '<cmd>Telescope live_grep<CR>', desc = "Live Grep" },
      { '<leader>fb', '<cmd>Telescope buffers<CR>', desc = "List Buffers" },
      { '<leader>fh', '<cmd>Telescope help_tags<CR>', desc = "Help Tags" },
      { '<leader>fr', '<cmd>Telescope lsp_references<CR>', desc = "LSP References" },
      { '<leader>fw', '<cmd>Telescope grep_string<CR>', desc = "Grep Word Under Cursor" },
      { '<leader>fz', '<cmd>Telescope grep_string search="" only_sort_text=true<CR>', desc = "Fuzzy Search" },
      { '<leader>fs', '<cmd>Telescope lsp_document_symbols<CR>', desc = "Document Symbols" },
      { '<leader>/',  '<cmd>Telescope current_buffer_fuzzy_find<CR>', desc = "Fuzzy Search Current Buffer" },
      { '<leader>fa', '<cmd>Telescope telescope-tabs list_tabs<CR>', desc = "Find Tabs" },
    },
    config = function()
      require('telescope').setup{
        defaults = {
          path_display = { "truncate" },
          mappings = {
            i = { -- Insert mode mappings
              ["<C-j>"] = require('telescope.actions').move_selection_next, -- Move down
              ["<C-k>"] = require('telescope.actions').move_selection_previous, -- Move up
            },
          },
          prompt_prefix = ": ",
          selection_caret = "> ",
          entry_prefix = "  ",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
          },
          file_ignore_patterns = { "node_modules", ".git/" },
          winblend = 0,
          border = {},
          color_devicons = true,
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            hidden = true,
            previewer = true,
          },
          live_grep = {
            only_sort_text = true, -- Ensure fuzzy matching is applied
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                    -- Enable fuzzy matching
            override_generic_sorter = true,  -- Replace the default generic sorter
            override_file_sorter = true,     -- Replace the default file sorter
            case_mode = "smart_case",        -- Smart case matching
          },
        },
      }
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",  -- Compiles the native binary
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    'LukasPietzschmann/telescope-tabs',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
        require('telescope-tabs').setup()
    end,
  },
}

